fun main() {
    val matcher1 = FiniteAutomatonMatcher("test", " abcdefghijklmnopqrstuvwxyz")
    matcher1.match("this is a test for testing finite automaton matcher")
    val matcher2 = KmpMatcher("test")
    matcher2.match("this is a test for testing kmp matcher")
}
