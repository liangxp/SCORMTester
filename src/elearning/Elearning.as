/**
 * Created with IntelliJ IDEA.
 * User: filipe
 * Date: 06/02/13
 * Time: 23:31
 * To change this template use File | Settings | File Templates.
 */
package elearning {
import com.demonsters.debugger.MonsterDebugger;
import com.fraktalo.SCORM.SCORMLessonStatus;
import com.fraktalo.SCORM.SCORMManager;
import com.fraktalo.SCORM.events.ScormEventCommit;
import com.fraktalo.SCORM.events.ScormEventInitialize;
import com.fraktalo.SCORM.events.ScormEventTerminate;

import flash.display.Sprite;

import managers.DebuggerManager;
import managers.EnvironmentManager;

import preloader.PreloaderManager;

public class Elearning  extends Sprite{
    private var serverTest:String = "192.168.0.5";
    public var offlineJSON:String = '{"___id":"1","___propertiesOrder":["suspend_data","objectives","comments","core"],"___className":"com.fraktalo.SCORM.vo.CMI","suspend_data":"","comments":"","core":{"___id":"5","___propertiesOrder":["lesson_location","student_name","session_time","score","lesson_status","total_time","student_id"],"___className":"com.fraktalo.SCORM.vo.Core","student_name":"","lesson_location":"","student_id":"","session_time":"","score":{"___id":"6","___propertiesOrder":["min","raw","max"],"___className":"com.fraktalo.SCORM.vo.Score","min":"","raw":"","max":""},"lesson_status":"","total_time":""},"objectives":{"___className":"Array","___id":"2","___value":[{"___id":"3","___propertiesOrder":["id","score","status"],"___className":"com.fraktalo.SCORM.vo.Objective","id":"","score":{"___id":"6","___propertiesOrder":["min","raw","max"],"___className":"com.fraktalo.SCORM.vo.Score","min":"","raw":"","max":""},"status":""}]}}';
    public var scorm:SCORMManager;
    public function Elearning() {
        MonsterDebugger.initialize(this);
        DebuggerManager.initialize(MonsterDebugger.trace);
        EnvironmentManager.initialize(loaderInfo.url, serverTest);
        scorm =  new SCORMManager();

        scorm.addEventListener(ScormEventInitialize.TYPE, onInitialize);
        scorm.addEventListener(ScormEventCommit.TYPE, onCommit);
        scorm.addEventListener(ScormEventTerminate.TYPE, onTerminate);
        scorm.initialize(DebuggerManager.debug,EnvironmentManager.isSCORM?"":offlineJSON,PreloaderManager.setVisible);
    }


    private function onTerminate(event : ScormEventTerminate) : void {
        trace("\n TERMINATED");
    }

    private function onCommit(event : ScormEventCommit) : void {
        trace( "\n COMMITED");
         scorm.terminate();
    }


    private function onInitialize(event : ScormEventInitialize) : void {
        DebuggerManager.debug("LOADED",event)
        trace("\n onInitialize - asdfasdfasdfa");
        scorm.cmi.core.score.max="100";
        scorm.cmi.core.score.min="0";
        scorm.cmi.core.score.raw="35";
        scorm.cmi.suspend_data= "adsfasdfasdfasdfasdfasdfadfasdfasdf";
        scorm.cmi.core.lesson_status =SCORMLessonStatus.COMPLETED;
        scorm.commit();

        // this.cmi.decodeJsonField(event._cmi);
        //this.txtReceive.text += "\n INICIALIZED";
    }
}
}
