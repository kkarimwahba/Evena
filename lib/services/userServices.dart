import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evena/models/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final db=FirebaseFirestore.instance;



signup(UserBase user)
{
  db.collection('users').add(user.tojson());
}

