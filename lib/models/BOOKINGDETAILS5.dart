/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the BOOKINGDETAILS5 type in your schema. */
class BOOKINGDETAILS5 extends amplify_core.Model {
  static const classType = const _BOOKINGDETAILS5ModelType();
  final String id;
  final String? _MRTStation;
  final int? _TripNo;
  final String? _BusStop;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BOOKINGDETAILS5ModelIdentifier get modelIdentifier {
      return BOOKINGDETAILS5ModelIdentifier(
        id: id
      );
  }
  
  String get MRTStation {
    try {
      return _MRTStation!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get TripNo {
    try {
      return _TripNo!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get BusStop {
    try {
      return _BusStop!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const BOOKINGDETAILS5._internal({required this.id, required MRTStation, required TripNo, required BusStop, createdAt, updatedAt}): _MRTStation = MRTStation, _TripNo = TripNo, _BusStop = BusStop, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BOOKINGDETAILS5({String? id, required String MRTStation, required int TripNo, required String BusStop}) {
    return BOOKINGDETAILS5._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      MRTStation: MRTStation,
      TripNo: TripNo,
      BusStop: BusStop);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BOOKINGDETAILS5 &&
      id == other.id &&
      _MRTStation == other._MRTStation &&
      _TripNo == other._TripNo &&
      _BusStop == other._BusStop;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BOOKINGDETAILS5 {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("MRTStation=" + "$_MRTStation" + ", ");
    buffer.write("TripNo=" + (_TripNo != null ? _TripNo!.toString() : "null") + ", ");
    buffer.write("BusStop=" + "$_BusStop" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BOOKINGDETAILS5 copyWith({String? MRTStation, int? TripNo, String? BusStop}) {
    return BOOKINGDETAILS5._internal(
      id: id,
      MRTStation: MRTStation ?? this.MRTStation,
      TripNo: TripNo ?? this.TripNo,
      BusStop: BusStop ?? this.BusStop);
  }
  
  BOOKINGDETAILS5 copyWithModelFieldValues({
    ModelFieldValue<String>? MRTStation,
    ModelFieldValue<int>? TripNo,
    ModelFieldValue<String>? BusStop
  }) {
    return BOOKINGDETAILS5._internal(
      id: id,
      MRTStation: MRTStation == null ? this.MRTStation : MRTStation.value,
      TripNo: TripNo == null ? this.TripNo : TripNo.value,
      BusStop: BusStop == null ? this.BusStop : BusStop.value
    );
  }
  
  BOOKINGDETAILS5.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _MRTStation = json['MRTStation'],
      _TripNo = (json['TripNo'] as num?)?.toInt(),
      _BusStop = json['BusStop'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'MRTStation': _MRTStation, 'TripNo': _TripNo, 'BusStop': _BusStop, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'MRTStation': _MRTStation,
    'TripNo': _TripNo,
    'BusStop': _BusStop,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<BOOKINGDETAILS5ModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<BOOKINGDETAILS5ModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final MRTSTATION = amplify_core.QueryField(fieldName: "MRTStation");
  static final TRIPNO = amplify_core.QueryField(fieldName: "TripNo");
  static final BUSSTOP = amplify_core.QueryField(fieldName: "BusStop");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BOOKINGDETAILS5";
    modelSchemaDefinition.pluralName = "BOOKINGDETAILS5s";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BOOKINGDETAILS5.MRTSTATION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BOOKINGDETAILS5.TRIPNO,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BOOKINGDETAILS5.BUSSTOP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BOOKINGDETAILS5ModelType extends amplify_core.ModelType<BOOKINGDETAILS5> {
  const _BOOKINGDETAILS5ModelType();
  
  @override
  BOOKINGDETAILS5 fromJson(Map<String, dynamic> jsonData) {
    return BOOKINGDETAILS5.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'BOOKINGDETAILS5';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [BOOKINGDETAILS5] in your schema.
 */
class BOOKINGDETAILS5ModelIdentifier implements amplify_core.ModelIdentifier<BOOKINGDETAILS5> {
  final String id;

  /** Create an instance of BOOKINGDETAILS5ModelIdentifier using [id] the primary key. */
  const BOOKINGDETAILS5ModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'BOOKINGDETAILS5ModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BOOKINGDETAILS5ModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}