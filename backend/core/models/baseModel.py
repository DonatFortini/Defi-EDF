import os
import zipfile
import json
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import transforms
from torch.utils.data import Dataset, DataLoader
from PIL import Image
from abc import ABC, abstractmethod


class ImageDataset(Dataset):
    def __init__(self, annotations, img_dir, transform=None):
        self.annotations = annotations
        self.img_dir = img_dir
        self.transform = transform

    def __len__(self):
        return len(self.annotations)

    def __getitem__(self, idx):
        annotation = self.annotations[idx]
        img_path = os.path.join(self.img_dir, annotation['file_name'])
        image = Image.open(img_path).convert('L')  # Grayscale
        label = annotation.get('label', 0)
        if self.transform:
            image = self.transform(image)
        return image, label


class BaseModel(ABC):
    def __init__(self, dataset_zip, output_size, model_name="BaseModel"):
        self.dataset_zip = dataset_zip
        self.output_size = output_size
        self.model_name = model_name
        self.image_dir = None
        self.annotations = None
        self.device = torch.device(
            "cuda" if torch.cuda.is_available() else "cpu")
        self.model = self.build_model().to(self.device)

    def load_dataset(self):
        dataset_temp_dir = os.path.join(
            os.path.dirname(__file__), 'dataset_temp')
        with zipfile.ZipFile(self.dataset_zip, 'r') as zip_ref:
            zip_ref.extractall(dataset_temp_dir)
        self.image_dir = os.path.join(dataset_temp_dir, "images")
        annotations_path = None
        for root, dirs, files in os.walk(dataset_temp_dir):
            if "images_data.json" in files:
                annotations_path = os.path.join(root, "images_data.json")
                break

        if annotations_path is None:
            raise FileNotFoundError(
                "images_data.json not found in the extracted dataset.")

        with open(annotations_path, 'r') as f:
            self.annotations = json.load(f)
        print(f"Dataset loaded with {len(self.annotations)} entries.")

    @abstractmethod
    def build_model(self):
        """Build the CNN model (implemented in child classes)."""
        pass

    def train(self, epochs=10, batch_size=32, lr=0.001):
        transform = transforms.Compose([
            transforms.Resize((64, 64)),
            transforms.RandomRotation(15),
            transforms.ColorJitter(brightness=0.5, contrast=0.5),
            transforms.ToTensor(),
        ])

        dataset = ImageDataset(
            self.annotations, self.image_dir, transform=transform)
        train_size = int(0.8 * len(dataset))
        val_size = len(dataset) - train_size
        train_dataset, val_dataset = torch.utils.data.random_split(
            dataset, [train_size, val_size])

        train_loader = DataLoader(
            train_dataset, batch_size=batch_size, shuffle=True)
        val_loader = DataLoader(
            val_dataset, batch_size=batch_size, shuffle=False)
        criterion = nn.CrossEntropyLoss()
        optimizer = optim.Adam(self.model.parameters(), lr=lr)

        for epoch in range(epochs):
            self.model.train()
            running_loss = 0.0
            for images, labels in train_loader:
                images, labels = images.to(self.device), labels.to(self.device)

                outputs = self.model(images)
                loss = criterion(outputs, labels)

                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

                running_loss += loss.item()

            print(
                f"Epoch {epoch + 1}/{epochs}, Loss: {running_loss / len(train_loader):.4f}")

            self.model.eval()
            correct, total = 0, 0
            with torch.no_grad():
                for images, labels in val_loader:
                    images, labels = images.to(
                        self.device), labels.to(self.device)
                    outputs = self.model(images)
                    _, predicted = torch.max(outputs, 1)
                    total += labels.size(0)
                    correct += (predicted == labels).sum().item()

            print(f"Validation Accuracy: {100 * correct / total:.2f}%")

    def predict(self, image_path):
        transform = transforms.Compose([
            transforms.Resize((64, 64)),
            transforms.ToTensor(),
        ])
        image = Image.open(image_path).convert('L')
        image = transform(image).unsqueeze(0).to(self.device)

        self.model.eval()
        with torch.no_grad():
            output = self.model(image)
            _, predicted = torch.max(output, 1)
        return predicted.item()
