# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class DefautReleve(models.Model):
    id_releve = models.AutoField(primary_key=True)
    id_vehicule = models.ForeignKey('Vehicule', models.DO_NOTHING, db_column='id_vehicule')
    id_defaut = models.ForeignKey('TypeDefaut', models.DO_NOTHING, db_column='id_defaut')
    date_releve = models.DateTimeField()
    commentaire_libre = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'defaut_releve'


class Destination(models.Model):
    id_destination = models.AutoField(primary_key=True)
    nom_destination = models.CharField(max_length=100)
    latitude = models.DecimalField(max_digits=16, decimal_places=14)
    longitude = models.DecimalField(max_digits=16, decimal_places=14)

    class Meta:
        managed = False
        db_table = 'destination'


class Modele(models.Model):
    id_modele = models.AutoField(primary_key=True)
    nom_modele = models.CharField(max_length=100)
    id_propulsion = models.ForeignKey('Propulsion', models.DO_NOTHING, db_column='id_propulsion')
    nb_places = models.IntegerField()
    autonomie_theorique = models.IntegerField(blank=True, null=True)
    taille_batterie = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    conso_kwh_100 = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    conso_lt_100 = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'modele'


class Propulsion(models.Model):
    id_propulsion = models.AutoField(primary_key=True)
    type_propulsion = models.CharField(unique=True, max_length=20)

    class Meta:
        managed = False
        db_table = 'propulsion'


class ReleveKm(models.Model):
    id_releve = models.AutoField(primary_key=True)
    id_vehicule = models.ForeignKey('Vehicule', models.DO_NOTHING, db_column='id_vehicule')
    releve_km = models.DecimalField(max_digits=10, decimal_places=2)
    date_releve = models.DateTimeField()
    source_releve = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'releve_km'


class Reservation(models.Model):
    id_reservation = models.AutoField(primary_key=True)
    id_vehicule = models.ForeignKey('Vehicule', models.DO_NOTHING, db_column='id_vehicule')
    id_utilisateur = models.ForeignKey('Utilisateur', models.DO_NOTHING, db_column='id_utilisateur')
    date_debut = models.DateTimeField()
    date_fin = models.DateTimeField()
    nb_places_reservees = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'reservation'


class SiteRattachement(models.Model):
    id_site = models.AutoField(primary_key=True)
    nom_site = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'site_rattachement'


class TypeDefaut(models.Model):
    id_defaut = models.AutoField(primary_key=True)
    categorie = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'type_defaut'


class Utilisateur(models.Model):
    id_utilisateur = models.AutoField(primary_key=True)
    nom_utilisateur = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'utilisateur'


class Vehicule(models.Model):
    id_vehicule = models.AutoField(primary_key=True)
    immatriculation = models.CharField(unique=True, max_length=20)
    id_modele = models.ForeignKey(Modele, models.DO_NOTHING, db_column='id_modele')
    id_site = models.ForeignKey(SiteRattachement, models.DO_NOTHING, db_column='id_site')

    class Meta:
        managed = False
        db_table = 'vehicule'
