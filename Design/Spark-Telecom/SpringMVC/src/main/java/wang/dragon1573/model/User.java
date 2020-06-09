package wang.dragon1573.model;

/**
 * 用户信息对象
 *
 * @author Dragon1573
 */
public class User {
    /** 用户编号 */
    private int id;
    /** 用户昵称 */
    private String nickname;
    /** 用户密码 */
    private String password;
    /** 用户状态 */
    private int state;
    /** 用户账号 */
    private String userId;

    public int getId() {
        return id;
    }

    public void setId(final int id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(final String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public int getState() {
        return state;
    }

    public void setState(final int state) {
        this.state = state;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(final String userId) {
        this.userId = userId;
    }
}
