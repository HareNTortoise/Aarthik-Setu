package helper

import (
	"encoding/json"
)

func StructToMap(instance interface{}) (map[string]interface{}, error) {
	data, err := json.Marshal(instance)
	if err != nil {
		return nil, err
	}

	var dataMap map[string]interface{}
	if err := json.Unmarshal(data, &dataMap); err != nil {
		return nil, err
	}

	return dataMap, nil
}

func MapToStructWithType(dataMap map[string]interface{}, resultType interface{}) (interface{}, error) {
	data, err := json.Marshal(dataMap)
	if err != nil {
		return nil, err
	}

	result := resultType
	if err := json.Unmarshal(data, &result); err != nil {
		return nil, err
	}

	return result, nil
}
