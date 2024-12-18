from plateModel import PlateModel

plate_model = PlateModel(
    # Alphanumeric classes
    dataset_zip="core/datasets/dataset.zip", output_size=36)
plate_model.load_dataset()
plate_model.train(epochs=10)
print("Plate prediction:", plate_model.predict(
    "core/datasets/CV_immatriculation/images/test_file1.jpeg"))
