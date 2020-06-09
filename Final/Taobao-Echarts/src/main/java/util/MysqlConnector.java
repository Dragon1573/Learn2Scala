package util;

import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

/**
 * MySQL数据库连接工具类
 *
 * @author Dragon1573
 * @since 2020/05/04
 */
public class MysqlConnector {
    private static Connection connection = null;
    private static ResultSet resultSet = null;
    private static Statement statement = null;

    /**
     * 买家消费行为比例
     */
    public static ArrayList<String[]> buyRate() {
        ArrayList<String[]> list = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(
                "SELECT action, COUNT(*) num FROM user_log GROUP BY action DESC;"
            );
            while (resultSet.next()) {
                String[] temp = {
                    resultSet.getString("action"), resultSet.getString("num")
                };
                list.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return list;
    }

    /**
     * 建立数据库远程连接
     */
    private static void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbtaobao?charset=utf8&&useSSL=false",
                "root", "root"
            );
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * 断开数据库远程连接
     */
    private static void disconnect() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            connection = null;
        }
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            resultSet = null;
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            statement = null;
        }
        try {
            Enumeration<Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                DriverManager.deregisterDriver(drivers.nextElement());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 男女买家各年龄段交易量对比
     */
    public static ArrayList<String[]> genderAgeRate() {
        ArrayList<String[]> list = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(
                "SELECT gender, age_range, COUNT(*) num FROM user_log "
                + "GROUP BY gender, age_range DESC;"
            );
            while (resultSet.next()) {
                String[] temp = {
                    resultSet.getString("gender"),
                    resultSet.getString("age_range"),
                    resultSet.getString("num")
                };
                list.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return list;
    }

    /**
     * 买家性别交易量对比
     */
    public static ArrayList<String[]> genderRate() {
        ArrayList<String[]> list = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(
                "SELECT gender, COUNT(*) num FROM user_log GROUP BY gender DESC;"
            );
            while (resultSet.next()) {
                String[] temp = {
                    resultSet.getString("gender"), resultSet.getString("num")
                };
                list.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return list;
    }

    /**
     * 各省/市/自治区成交量对比
     */
    public static ArrayList<String[]> provinceRate() {
        ArrayList<String[]> list = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(
                "SELECT province, COUNT(*) num FROM user_log "
                + "GROUP BY province ORDER BY num DESC;"
            );
            while (resultSet.next()) {
                String[] temp = {
                    resultSet.getString("province"), resultSet.getString("num")
                };
                list.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return list;
    }

    /**
     * 获取销售量前五的商品类别
     */
    public static ArrayList<String[]> topFive() {
        ArrayList<String[]> list = new ArrayList<>();
        connect();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(
                "SELECT cat_id, COUNT(*) num FROM user_log "
                + "GROUP BY cat_id ORDER BY num DESC LIMIT 5;"
            );
            while (resultSet.next()) {
                String[] temp = {
                    resultSet.getString("cat_id"), resultSet.getString("num")
                };
                list.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        disconnect();
        return list;
    }
}
