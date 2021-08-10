import ResultCard from './shared/ResultCard'
import { Props } from './types'
import * as S from './styles'

const Results = ({ results }: Props) => {
  return (
    <S.Container>
      {results.map((result) => (
        <ResultCard key={result.method} result={result} />
      ))}
    </S.Container>
  )
}

export default Results
