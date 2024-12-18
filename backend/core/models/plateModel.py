from baseModel import BaseModel
import torch.nn as nn
from torchvision import transforms
from PIL import Image
import torch


class PlateModel(BaseModel):
    def build_model(self):
        return nn.Sequential(
            nn.Conv2d(1, 32, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.MaxPool2d(2, 2),
            nn.Conv2d(32, 64, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.MaxPool2d(2, 2),
            nn.Flatten(),
            nn.Linear(64 * 16 * 16, 128),
            nn.ReLU(),
            nn.Linear(128, 8 * 36)
        )

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
            # Reshape to (num_characters, num_classes)
            output = output.view(-1, 36)
            # Take the class with max probability
            _, predicted_indices = torch.max(output, 1)

        # Map indices to characters
        characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-"
        plate = "".join([characters[idx] for idx in predicted_indices])
        return plate
