DROP TABLE IF EXISTS bugs;
CREATE TABLE bugs (
  id INT,
  severity INT,
  open_date DATE,
  close_date DATE
);

INSERT INTO bugs VALUES
  (
    1, 1,
    STR_TO_DATE('2011-12-31', '%Y-%m-%d'),
    STR_TO_DATE('2011-12-31', '%Y-%m-%d')
  ),
  (
    2, 1,
    STR_TO_DATE('2012-01-01', '%Y-%m-%d'),
    STR_TO_DATE('2012-01-02', '%Y-%m-%d')
  ),
  (
    3, 1,
    STR_TO_DATE('2012-01-03', '%Y-%m-%d'),
    STR_TO_DATE('2012-01-03', '%Y-%m-%d')
  ),
  (
    4, 1,
    STR_TO_DATE('2012-01-03', '%Y-%m-%d'),
    STR_TO_DATE('2012-01-04', '%Y-%m-%d')
  ),
  (
    5, 1,
    STR_TO_DATE('2012-01-06', '%Y-%m-%d'),
    STR_TO_DATE('2012-01-07', '%Y-%m-%d')

  );

DROP PROCEDURE IF EXISTS search;
DELIMITER $$

CREATE PROCEDURE search (start DATE, end DATE)
BEGIN
  DECLARE result VARCHAR(255);
  SET @result = '';

  SET @iterDate = start;
  label1: LOOP
     IF @iterDate = start THEN
       SET @result = CONCAT(@result, ' SELECT * FROM bugs WHERE open_date <= DATE(\'',@iterDate,'\') AND close_date = DATE(\'',@iterDate,'\') UNION ALL');
     ELSEIF @iterDate = end THEN
       SET @result = CONCAT(@result, ' SELECT * FROM bugs WHERE open_date <= DATE(\'',@iterDate,'\') AND close_date >= DATE(\'',@iterDate,'\') UNION ALL');
     ELSE
       SET @result = CONCAT(@result, ' SELECT * FROM bugs WHERE open_date <= DATE(\'',@iterDate,'\') AND close_date = DATE(\'',@iterDate,'\') UNION ALL');
     END IF;


     SET @iterDate = DATE_ADD(@iterDate, INTERVAL 1 DAY);
     IF @iterDate <= end THEN
        ITERATE label1;
     END IF;
     LEAVE label1;
   END LOOP label1;

   SET @result = LEFT(@result, LENGTH(@result)-LENGTH('UNION ALL'));

   PREPARE stmt FROM @result;
   EXECUTE stmt;
END

$$

DELIMITER ;

CALL search(
  STR_TO_DATE('2012-01-01', '%Y-%m-%d'),

  STR_TO_DATE('2012-01-03', '%Y-%m-%d'));
