from rest_framework import viewsets
from .models import Voiture, Destination, Planning_reservation
from .serializers import VoitureSerializer, DestinationSerializer, PlanningReservationSerializer

class VoitureViewSet(viewsets.ModelViewSet):
    queryset = Voiture.objects.all()
    serializer_class = VoitureSerializer

class DestinationViewSet(viewsets.ModelViewSet):
    queryset = Destination.objects.all()
    serializer_class = DestinationSerializer

class PlanningReservationViewSet(viewsets.ModelViewSet):
    queryset = Planning_reservation.objects.all()
    serializer_class = PlanningReservationSerializer