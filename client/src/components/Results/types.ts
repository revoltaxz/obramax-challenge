export interface Result {
  method: string
  valid: boolean
  incompatibilities: string[]
}

export interface Props {
  results: Result[]
}
