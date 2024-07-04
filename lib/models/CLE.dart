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


/** This is an auto generated class representing the CLE type in your schema. */
class CLE extends amplify_core.Model {
  static const classType = const _CLEModelType();
  final String id;
  final String? _BusStop;
  final int? _TripNo;
  final int? _Count;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CLEModelIdentifier get modelIdentifier {
      return CLEModelIdentifier(
        id: id
      );
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
  
  int get Count {
    try {
      return _Count!;
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
  
  const CLE._internal({required this.id, required BusStop, required TripNo, required Count, createdAt, updatedAt}): _BusStop = BusStop, _TripNo = TripNo, _Count = Count, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory CLE({String? id, required String BusStop, required int TripNo, required int Count}) {
    return CLE._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      BusStop: BusStop,
      TripNo: TripNo,
      Count: Count);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CLE &&
      id == other.id &&
      _BusStop == other._BusStop &&
      _TripNo == other._TripNo &&
      _Count == other._Count;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CLE {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("BusStop=" + "$_BusStop" + ", ");
    buffer.write("TripNo=" + (_TripNo != null ? _TripNo!.toString() : "null") + ", ");
    buffer.write("Count=" + (_Count != null ? _Count!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CLE copyWith({String? BusStop, int? TripNo, int? Count}) {
    return CLE._internal(
      id: id,
      BusStop: BusStop ?? this.BusStop,
      TripNo: TripNo ?? this.TripNo,
      Count: Count ?? this.Count);
  }
  
  CLE copyWithModelFieldValues({
    ModelFieldValue<String>? BusStop,
    ModelFieldValue<int>? TripNo,
    ModelFieldValue<int>? Count
  }) {
    return CLE._internal(
      id: id,
      BusStop: BusStop == null ? this.BusStop : BusStop.value,
      TripNo: TripNo == null ? this.TripNo : TripNo.value,
      Count: Count == null ? this.Count : Count.value
    );
  }
  
  CLE.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _BusStop = json['BusStop'],
      _TripNo = (json['TripNo'] as num?)?.toInt(),
      _Count = (json['Count'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'BusStop': _BusStop, 'TripNo': _TripNo, 'Count': _Count, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'BusStop': _BusStop,
    'TripNo': _TripNo,
    'Count': _Count,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CLEModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CLEModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final BUSSTOP = amplify_core.QueryField(fieldName: "BusStop");
  static final TRIPNO = amplify_core.QueryField(fieldName: "TripNo");
  static final COUNT = amplify_core.QueryField(fieldName: "Count");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CLE";
    modelSchemaDefinition.pluralName = "CLES";
    
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
      key: CLE.BUSSTOP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CLE.TRIPNO,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: CLE.COUNT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
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

class _CLEModelType extends amplify_core.ModelType<CLE> {
  const _CLEModelType();
  
  @override
  CLE fromJson(Map<String, dynamic> jsonData) {
    return CLE.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'CLE';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [CLE] in your schema.
 */
class CLEModelIdentifier implements amplify_core.ModelIdentifier<CLE> {
  final String id;

  /** Create an instance of CLEModelIdentifier using [id] the primary key. */
  const CLEModelIdentifier({
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
  String toString() => 'CLEModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CLEModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}