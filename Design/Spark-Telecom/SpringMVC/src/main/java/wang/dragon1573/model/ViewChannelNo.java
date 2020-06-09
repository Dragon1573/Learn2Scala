package wang.dragon1573.model;

/**
 * v_channelNo视图（MySQL映射）
 *
 * @author Dragon1573
 */
public class ViewChannelNo {
    /** 渠道名称 */
    private String channelName;
    /** 用户数量 */
    private int num;

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(final String channelName) {
        this.channelName = channelName;
    }

    public int getNum() {
        return num;
    }

    public void setNum(final int num) {
        this.num = num;
    }
}
