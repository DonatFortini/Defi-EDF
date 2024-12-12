from rest_framework import serializers
from .models import Voiture, Destination, Planning_reservation

class VoitureSerializer(serializers.ModelSerializer):
    class Meta:
        model = Voiture
        fields = '__all__'

class DestinationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Destination
        fields = '__all__'

class PlanningReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Planning_reservation
        fields = '__all__'