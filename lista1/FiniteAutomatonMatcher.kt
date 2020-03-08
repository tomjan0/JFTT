import kotlin.math.min

class FiniteAutomatonMatcher(pattern: String, alphabet: String) {
    private val transitions: HashMap<Any, Int> = computeTransitionFunction(pattern, alphabet)
    private val m = pattern.length

    private fun computeTransitionFunction(pattern: String, alphabet: String): HashMap<Any, Int> {
        val transitions = HashMap<Any, Int>()
        val m = pattern.length
        for (q in 0..m) {
            alphabet.forEach {
                var k = min(m + 1, q + 2)
                do {
                    k -= 1
                } while (!"${pattern.subSequence(0, q)}$it".endsWith(pattern.subSequence(0, k)) && k > 0)
                transitions[Pair(q, it)] = k
            }
        }
        return transitions
    }

    fun match(text: String) {
        var q = 0
        for (i in 0 until text.length) {
            q = transitions[Pair(q, text[i])]!!
            if (q == m) {
                println("Pattern occurs with shift ${i - m + 1}")
            }
        }
    }
}
