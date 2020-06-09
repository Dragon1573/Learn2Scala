package wang.dragon1573.model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * detail数据表（MySQL映射）
 *
 * @author Dragon1573
 */
public class ViewUserDetail {
    /** 首次登录时间 */
    private String first_Login_Time;
    /** 用户识别号（IMEI） */
    private String imei;
    /** 登录次数 */
    private int log_Times;
    /** 在线时长（秒） */
    private int online_Time;
    /** 请求地址 */
    private String requestIp;
    /** 请求类型 */
    private String requestTypeName;

    public String getFirst_Login_Time() {
        String formatted = "";
        // 创建时间格式化器
        SimpleDateFormat format = (SimpleDateFormat)DateFormat.getDateTimeInstance();

        // 将14位时间字符串转换为Java时间
        try {
            // 按指定格式解析字符串
            format.applyPattern("yyyyMMddHHmmss");
            Date date = format.parse(first_Login_Time);
            // 按新格式重新生成字符串
            format.applyPattern("yyyy年MM月dd日 HH:mm:ss");
            formatted = format.format(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // 返回标准时间格式
        return formatted;
    }

    public void setFirst_Login_Time(final String first_Login_Time) {
        this.first_Login_Time = first_Login_Time;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(final String imei) {
        this.imei = imei;
    }

    public int getLog_Times() {
        return log_Times;
    }

    public void setLog_Times(final int log_Times) {
        this.log_Times = log_Times;
    }

    public int getOnline_Time() {
        return online_Time;
    }

    public void setOnline_Time(final int online_Time) {
        this.online_Time = online_Time;
    }

    public String getRequestIp() {
        return requestIp;
    }

    public void setRequestIp(final String requestIp) {
        this.requestIp = requestIp;
    }

    public String getRequestTypeName() {
        return requestTypeName;
    }

    public void setRequestTypeName(final String requestTypeName) {
        this.requestTypeName = requestTypeName;
    }
}
