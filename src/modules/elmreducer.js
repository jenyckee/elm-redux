export const UPDATE = 'elm/UPDATE'

const initialState = {}

export default (state = initialState, action) => {
	switch (action.type) {
		case UPDATE: 
			return action.value
		default:
			return state
	}
}

export function update(model) {
  return { 
    type: UPDATE,
    value: model 
  }
}

