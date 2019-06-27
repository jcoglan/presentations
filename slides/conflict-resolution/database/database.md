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


!SLIDE title
# persistent data structures
# operational transforms
# CRDTs
