from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import VoitureViewSet, DestinationViewSet, PlanningReservationViewSet

router = DefaultRouter()
router.register(r'voitures', VoitureViewSet)
router.register(r'destinations', DestinationViewSet)
router.register(r'reservations', PlanningReservationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]