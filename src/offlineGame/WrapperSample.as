/**
 * Created with IntelliJ IDEA.
 * User: filipe
 * Date: 06/02/13
 * Time: 22:40
 * To change this template use File | Settings | File Templates.
 */
package offlineGame {
import com.demonsters.debugger.MonsterDebugger;
import com.fraktalo.SCORM.SCORMChannelKeys;
import com.fraktalo.SCORM.Wrapper;
import com.fraktalo.SCORM.events.ScormEventCommit;
import com.fraktalo.SCORM.events.ScormEventMessage;
import com.fraktalo.SCORM.vo.CMI;
import com.fraktalo.SCORM.vo.Core;
import com.fraktalo.SCORM.vo.Objective;
import com.fraktalo.SCORM.vo.Score;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextRenderer;

import managers.DebuggerManager;
import managers.EnvironmentManager;

public class WrapperSample extends  Sprite{

    {CMI, Objective, Score, Core}
    public var wrapper:Wrapper;
    public var offlineJSON:String = '{"___id":"1","___propertiesOrder":["suspend_data","objectives","comments","core"],"___className":"com.fraktalo.SCORM.vo.CMI","suspend_data":"","comments":"","core":{"___id":"5","___propertiesOrder":["lesson_location","student_name","session_time","score","lesson_status","total_time","student_id"],"___className":"com.fraktalo.SCORM.vo.Core","student_name":"","lesson_location":"","student_id":"","session_time":"","score":{"___id":"6","___propertiesOrder":["min","raw","max"],"___className":"com.fraktalo.SCORM.vo.Score","min":"","raw":"","max":""},"lesson_status":"","total_time":""},"objectives":{"___className":"Array","___id":"2","___value":[{"___id":"3","___propertiesOrder":["id","score","status"],"___className":"com.fraktalo.SCORM.vo.Objective","id":"","score":{"___id":"6","___propertiesOrder":["min","raw","max"],"___className":"com.fraktalo.SCORM.vo.Score","min":"","raw":"","max":""},"status":""}]}}';
    public function WrapperSample() {
        SCORMChannelKeys.SOCKET_KEY = SCORMChannelKeys.SOCKET_KEY+"3";
        SCORMChannelKeys.WRAPPER_KEY= SCORMChannelKeys.WRAPPER_KEY+"3";
        MonsterDebugger.initialize(this);
        DebuggerManager.initialize(MonsterDebugger.trace);
        EnvironmentManager.initialize(loaderInfo.url,"192.168.0.5");
        wrapper = new Wrapper();
        MonsterDebugger.initialize(this);


        wrapper.removeEventListener(ScormEventMessage.TYPE, onMessage);
        wrapper.removeEventListener(ScormEventCommit.TYPE, onCommit);

        wrapper.initWrapper(MonsterDebugger.trace,EnvironmentManager.isSCORM?"":offlineJSON);
        var t:TextField = new TextField();
        t.text="wrapper2: "+EnvironmentManager.isSCORM.toString() ;
        t.x = 100;
        t.y = 100;
        this.addChild(t);
        MonsterDebugger.trace("WrapperSample","")
    }
    private function onMessage(event : ScormEventMessage) : void {
        MonsterDebugger.trace("WRAPPERE+ onMessage",event)
    }
    private function onCommit(event : ScormEventCommit) : void {
        MonsterDebugger.trace("WRAPPERE+ onCommit",event)
    }
}
}
