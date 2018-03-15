package Model;

import java.util.concurrent.atomic.AtomicInteger;

/**
 *
 * @author mathiasjepsen
 */
public class Counter {
    
    private AtomicInteger counter;

    public Counter() {
        this.counter = new AtomicInteger(1);
    }

    public int getCount() {
        return counter.incrementAndGet();
    }

    public void setCount(int count) {
        this.counter.set(count);
    }
    
    public int getWithoutIncrement() {
        return counter.get();
    }
    
}
