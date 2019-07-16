!SLIDE title
# Databases


!SLIDE
```
            > SELECT * FROM files;

              +-----+---------+
              | id  | value   |
              +-----+---------+
              | f   | 2       |
              | g   | 3       |
              | h   | 1       |
              +-----+---------+
```


!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 5   |
      WHERE id = g    |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 5   |
      WHERE id = g    |   UPDATE files
                      |       SET value = 4
                      |       WHERE id = f
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 5   |
      WHERE id = g    |   UPDATE files
                      |       SET value = 4
                      |       WHERE id = f
  UPDATE files        |
      SET value = 6   |
      WHERE id = h    |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 5   |
      WHERE id = g    |   UPDATE files
                      |       SET value = 4
                      |       WHERE id = f
  UPDATE files        |
      SET value = 6   |
      WHERE id = h    |
                      |   COMMIT
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 5   |
      WHERE id = g    |   UPDATE files
                      |       SET value = 4
                      |       WHERE id = f
  UPDATE files        |
      SET value = 6   |
      WHERE id = h    |
                      |   COMMIT
  COMMIT              |
                      |
```


!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |   -- T1 holds write
                      |   -- lock on id = g
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |   -- T1 holds write
                      |   -- lock on id = g
                      |
                      |   UPDATE files
                      |       SET value = 5
                      |       WHERE id = g
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |   -- T1 holds write
                      |   -- lock on id = g
                      |
                      |   UPDATE files
                      |       SET value = 5
                      |       WHERE id = g
                      |
                      |   😱
                      |
```


!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
  COMMIT              |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
  COMMIT              |   -- T1 releases lock
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
  COMMIT              |   -- T1 releases lock
                      |
                      |   UPDATE files
                      |       SET value = 5
                      |       WHERE id = g
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
  COMMIT              |   -- T1 releases lock
                      |
                      |   UPDATE files
                      |       SET value = 5
                      |       WHERE id = g
                      |
                      |   COMMIT
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  UPDATE files        |
      SET value = 4   |
      WHERE id = g    |
                      |
  COMMIT              |   -- T1 releases lock
                      |
                      |   SELECT * FROM files
                      |       WHERE id = g
                      |       FOR UPDATE
                      |
                      |   -- etc.
```


!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |   -- T1 holds range
                      |   -- lock on id = x
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |   -- T1 holds range
                      |   -- lock on id = x
                      |
  INSERT INTO files   |
      (id, value)     |
      VALUES (x/y, 5) |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |   -- T1 holds range
                      |   -- lock on id = x
                      |
  INSERT INTO files   |
      (id, value)     |   INSERT INTO files
      VALUES (x/y, 5) |       (id, value)
                      |       VALUES (x, 4)
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |   -- T1 holds range
                      |   -- lock on id = x
                      |
  INSERT INTO files   |
      (id, value)     |   INSERT INTO files
      VALUES (x/y, 5) |       (id, value)
                      |       VALUES (x, 4)
                      |
                      |   😱
                      |
```


!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |
                      |
  INSERT INTO files   |
      (id, value)     |
      VALUES (x/y, 5) |
                      |
                      |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |
                      |
  INSERT INTO files   |
      (id, value)     |
      VALUES (x/y, 5) |
                      |
  COMMIT              |
                      |
                      |
                      |
```

!SLIDE
```
  transaction 1       |   transaction 2
----------------------+----------------------
                      |
  SELECT * FROM files |
      WHERE id = x    |
                      |
  INSERT INTO files   |
      (id, value)     |
      VALUES (x/y, 5) |
                      |
  COMMIT              |
                      |   INSERT INTO files
                      |       (id, value)
                      |       VALUES (x, 4)
```


!SLIDE title
# Concurrent editing


!SLIDE
```
counter = 0

threads = (1..1000).map do
  Thread.new { counter += 1 }
end

threads.each(&:join)

puts counter
```


!SLIDE
```
counter = 0
mutex = Mutex.new

threads = (1..1000).map do
  Thread.new do
    mutex.synchronize { counter += 1 }
  end
end

threads.each(&:join)

puts counter
```


!SLIDE
```
let counter = {
  value: 0,

  async inc() {
    let tmp = await this.value
    this.value = tmp + 1
  }
}
```


!SLIDE
```
async function main() {
  let range = new Array(1000).fill()

  let promises = range.map(() => counter.inc())
  await Promise.all(promises)

  console.log(counter.value) // -> 1
}
```


!SLIDE
```
async function main() {
  let range = new Array(1000).fill()

  await range.reduce(
    (state) => state.then(() => counter.inc()),
    Promise.resolve()
  )

  console.log(counter.value) // -> 1000
}
```


!SLIDE

    let counter = Arc::new(Mutex::new(0));

    let threads: Vec<_> = (0..1000).map(|_| {
        let ctr = Arc::clone(&counter);

        thread::spawn(move || {
            let mut ctr = ctr.lock().unwrap();
            *ctr += 1;
        })
    }).collect();

    for th in threads { 
        th.join();
    }
