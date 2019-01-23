package nape;
/**
 * Platform specific Array type.
 * <br/><br/>
 * For flash10+ This is <code>flash.Vector&lt;T&gt;</code>, and otherwise
 * <code>Array&lt;T&gt;</code>.
 * <pre>
 * #if flash10
 *     typedef TArray&lt;T&gt; = flash.Vector&lt;T&gt;;
 * #else
 *     typedef TArray&lt;T&gt; = Array&lt;T&gt;;
 * #end
 * </pre>
 */
typedef TArray<T>=#if flash10 flash.Vector<T>#else Array<T>#end;
