{{- define "hpaSpec" }}
{
    "description": "MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once).",
    "properties": {
        "external": {
            "description": "ExternalMetricSource indicates how to scale on a metric not associated with any Kubernetes object (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster). Exactly one \"target\" type should be set.",
            "properties": {
                "metricName": {
                    "description": "metricName is the name of the metric in question.",
                    "type": "string"
                },
                "metricSelector": {
                    "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.",
                    "properties": {
                        "matchExpressions": {
                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                            "items": {
                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                "properties": {
                                    "key": {
                                        "description": "key is the label key that the selector applies to.",
                                        "type": "string",
                                        "x-kubernetes-patch-merge-key": "key",
                                        "x-kubernetes-patch-strategy": "merge"
                                    },
                                    "operator": {
                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                        "type": "string"
                                    },
                                    "values": {
                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    }
                                },
                                "required": [
                                    "key",
                                    "operator"
                                ],
                                "type": "object"
                            },
                            "type": "array"
                        },
                        "matchLabels": {
                            "additionalProperties": {
                                "type": "string"
                            },
                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                            "type": "object"
                        }
                    },
                    "type": "object"
                },
                "targetAverageValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                },
                "targetValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                }
            },
            "required": [
                "metricName"
            ],
            "type": "object"
        },
        "object": {
            "description": "ObjectMetricSource indicates how to scale on a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).",
            "properties": {
                "averageValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                },
                "metricName": {
                    "description": "metricName is the name of the metric in question.",
                    "type": "string"
                },
                "selector": {
                    "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.",
                    "properties": {
                        "matchExpressions": {
                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                            "items": {
                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                "properties": {
                                    "key": {
                                        "description": "key is the label key that the selector applies to.",
                                        "type": "string",
                                        "x-kubernetes-patch-merge-key": "key",
                                        "x-kubernetes-patch-strategy": "merge"
                                    },
                                    "operator": {
                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                        "type": "string"
                                    },
                                    "values": {
                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    }
                                },
                                "required": [
                                    "key",
                                    "operator"
                                ],
                                "type": "object"
                            },
                            "type": "array"
                        },
                        "matchLabels": {
                            "additionalProperties": {
                                "type": "string"
                            },
                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                            "type": "object"
                        }
                    },
                    "type": "object"
                },
                "target": {
                    "description": "CrossVersionObjectReference contains enough information to let you identify the referred resource.",
                    "properties": {
                        "apiVersion": {
                            "description": "API version of the referent",
                            "type": "string"
                        },
                        "kind": {
                            "description": "Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds\"",
                            "type": "string"
                        },
                        "name": {
                            "description": "Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names",
                            "type": "string"
                        }
                    },
                    "required": [
                        "kind",
                        "name"
                    ],
                    "type": "object"
                },
                "targetValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                }
            },
            "required": [
                "target",
                "metricName",
                "targetValue"
            ],
            "type": "object"
        },
        "pods": {
            "description": "PodsMetricSource indicates how to scale on a metric describing each pod in the current scale target (for example, transactions-processed-per-second). The values will be averaged together before being compared to the target value.",
            "properties": {
                "metricName": {
                    "description": "metricName is the name of the metric in question",
                    "type": "string"
                },
                "selector": {
                    "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.",
                    "properties": {
                        "matchExpressions": {
                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                            "items": {
                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                "properties": {
                                    "key": {
                                        "description": "key is the label key that the selector applies to.",
                                        "type": "string",
                                        "x-kubernetes-patch-merge-key": "key",
                                        "x-kubernetes-patch-strategy": "merge"
                                    },
                                    "operator": {
                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                        "type": "string"
                                    },
                                    "values": {
                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                        "items": {
                                            "type": "string"
                                        },
                                        "type": "array"
                                    }
                                },
                                "required": [
                                    "key",
                                    "operator"
                                ],
                                "type": "object"
                            },
                            "type": "array"
                        },
                        "matchLabels": {
                            "additionalProperties": {
                                "type": "string"
                            },
                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                            "type": "object"
                        }
                    },
                    "type": "object"
                },
                "targetAverageValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                }
            },
            "required": [
                "metricName",
                "targetAverageValue"
            ],
            "type": "object"
        },
        "resource": {
            "description": "ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the \"pods\" source.  Only one \"target\" type should be set.",
            "properties": {
                "name": {
                    "description": "name is the name of the resource in question.",
                    "type": "string"
                },
                "targetAverageUtilization": {
                    "description": "targetAverageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.",
                    "format": "int32",
                    "type": "integer"
                },
                "targetAverageValue": {
                    "description": "Quantity is a fixed-point representation of a number. It provides convenient marshaling/unmarshaling in JSON and YAML, in addition to String() and Int64() accessors.\n\nThe serialization format is:\n\n<quantity>        ::= <signedNumber><suffix>\n  (Note that <suffix> may be empty, from the \"\" case in <decimalSI>.)\n<digit>           ::= 0 | 1 | ... | 9 <digits>          ::= <digit> | <digit><digits> <number>          ::= <digits> | <digits>.<digits> | <digits>. | .<digits> <sign>            ::= \"+\" | \"-\" <signedNumber>    ::= <number> | <sign><number> <suffix>          ::= <binarySI> | <decimalExponent> | <decimalSI> <binarySI>        ::= Ki | Mi | Gi | Ti | Pi | Ei\n  (International System of units; See: http://physics.nist.gov/cuu/Units/binary.html)\n<decimalSI>       ::= m | \"\" | k | M | G | T | P | E\n  (Note that 1024 = 1Ki but 1000 = 1k; I didn't choose the capitalization.)\n<decimalExponent> ::= \"e\" <signedNumber> | \"E\" <signedNumber>\n\nNo matter which of the three exponent forms is used, no quantity may represent a number greater than 2^63-1 in magnitude, nor may it have more than 3 decimal places. Numbers larger or more precise will be capped or rounded up. (E.g.: 0.1m will rounded up to 1m.) This may be extended in the future if we require larger or smaller quantities.\n\nWhen a Quantity is parsed from a string, it will remember the type of suffix it had, and will use the same type again when it is serialized.\n\nBefore serializing, Quantity will be put in \"canonical form\". This means that Exponent/suffix will be adjusted up or down (with a corresponding increase or decrease in Mantissa) such that:\n  a. No precision is lost\n  b. No fractional digits will be emitted\n  c. The exponent (or suffix) is as large as possible.\nThe sign will be omitted unless the number is negative.\n\nExamples:\n  1.5 will be serialized as \"1500m\"\n  1.5Gi will be serialized as \"1536Mi\"\n\nNote that the quantity will NEVER be internally represented by a floating point number. That is the whole point of this exercise.\n\nNon-canonical values will still parse as long as they are well formed, but will be re-emitted in their canonical form. (So always use canonical form, or don't diff.)\n\nThis format is intended to make it difficult to use these numbers without writing some sort of special handling code in the hopes that that will cause implementors to also use a fixed point implementation.",
                    "type": "string"
                }
            },
            "required": [
                "name"
            ],
            "type": "object"
        },
        "type": {
            "description": "type is the type of metric source.  It should be one of \"Object\", \"Pods\" or \"Resource\", each mapping to a matching field in the object.",
            "type": "string"
        }
    },
    "required": [
        "type"
    ],
    "type": "object"
}
{{- end }}
