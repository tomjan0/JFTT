class KmpMatcher(pattern: String) {
    private val m = pattern.length
    private val P = " $pattern"
    private val pi = computePrefixFunction()


    private fun computePrefixFunction(): Array<Int> {
        val pi = Array<Int>(m + 1) { 0 }
        pi[1] = 0
        var k = 0
        for (q in 2..m) {
            while (k > 0 && P[k + 1] != P[q])
                k = pi[k]
            if (P[k + 1] == P[q]) {
                k++
            }
            pi[q] = k
        }
        return pi
    }

    fun match(text: String) {
        val n = text.length
        val T = " $text"

        var q = 0
        for (i in 1..n) {
            while (q > 0 && P[q + 1] != T[i]) {
                q = pi[q]
            }
            if (P[q + 1] == T[i])
                q++
            if (q == m) {
                println("Pattern occurs with shift ${i - m}")
                q = pi[q]
            }
        }

    }

}
