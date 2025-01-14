@isTest
public class TestVerifyDate {

    @isTest
    static void testCheckDatesWithin30Days() {
        Date date1 = Date.today();
        Date date2 = Date.today().addDays(10);

        Date result = VerifyDate.checkDates(date1, date2);
        System.assertEquals(date2, result, 'The date should be within 30 days');
    }

    @isTest
    static void testCheckDatesOutside30Days() {
        Date date1 = Date.today();
        Date date2 = Date.today().addDays(40);

        Date result = VerifyDate.checkDates(date1, date2);
        Date expectedEndOfMonth = VerifyDate.setEndOfMonthDate(date1);
        System.assertEquals(expectedEndOfMonth, result, 'The date should be set to the end of the month');
    }

    @isTest
    static void testDateWithin30DaysTrue() {
        Date date1 = Date.today();
        Date date2 = Date.today().addDays(20);

        Boolean result = VerifyDate.dateWithin30Days(date1, date2);
        System.assertEquals(true, result, 'The date should be within 30 days');
    }

    @isTest
    static void testDateWithin30DaysFalsePast() {
        Date date1 = Date.today();
        Date date2 = Date.today().addDays(-1);

        Boolean result = VerifyDate.dateWithin30Days(date1, date2);
        System.assertEquals(false, result, 'The date should not be in the past');
    }

    @isTest
    static void testDateWithin30DaysFalseBeyond30Days() {
        Date date1 = Date.today();
        Date date2 = Date.today().addDays(35);

        Boolean result = VerifyDate.dateWithin30Days(date1, date2);
        System.assertEquals(false, result, 'The date should not be beyond 30 days');
    }

    @isTest
    static void testSetEndOfMonthDate() {
        Date date1 = Date.newInstance(2024, 2, 15); // February 15, 2024 (a leap year)

        Date result = VerifyDate.setEndOfMonthDate(date1);
        Date expectedEndOfMonth = Date.newInstance(2024, 2, 29); // February 29, 2024
        System.assertEquals(expectedEndOfMonth, result, 'The date should be set to the end of February 2024');
    }

    @isTest
    static void testSetEndOfMonthDateNonLeapYear() {
        Date date1 = Date.newInstance(2023, 2, 15); // February 15, 2023 (non-leap year)

        Date result = VerifyDate.setEndOfMonthDate(date1);
        Date expectedEndOfMonth = Date.newInstance(2023, 2, 28); // February 28, 2023
        System.assertEquals(expectedEndOfMonth, result, 'The date should be set to the end of February 2023');
    }

    @isTest
    static void testSetEndOfMonthDateDifferentMonth() {
        Date date1 = Date.newInstance(2023, 4, 15); // April 15, 2023

        Date result = VerifyDate.setEndOfMonthDate(date1);
        Date expectedEndOfMonth = Date.newInstance(2023, 4, 30); // April 30, 2023
        System.assertEquals(expectedEndOfMonth, result, 'The date should be set to the end of April 2023');
    }
}