/**
 * Created with IntelliJ IDEA.
 * User: filipe
 * Date: 06/02/13
 * Time: 23:29
 * To change this template use File | Settings | File Templates.
 */
package offlineGame {
import com.demonsters.debugger.MonsterDebugger;
import com.fraktalo.SCORM.CoreSCO;
import com.fraktalo.SCORM.SCORMChannelKeys;
import com.fraktalo.SCORM.SCORMLessonStatus;
import com.fraktalo.SCORM.Socket;
import com.fraktalo.SCORM.events.ScormEventCommit;
import com.fraktalo.SCORM.events.ScormEventConnection;
import com.fraktalo.SCORM.events.ScormEventInitialize;
import com.fraktalo.SCORM.events.ScormEventMessage;
import com.fraktalo.SCORM.events.ScormEventTerminate;
import com.fraktalo.SCORM.vo.CMI;
import com.fraktalo.SCORM.vo.Core;
import com.fraktalo.SCORM.vo.Objective;
import com.fraktalo.SCORM.vo.Score;

import flash.display.Sprite;
import flash.text.TextField;

import managers.DebuggerManager;
import managers.EnvironmentManager;

import preloader.PreloaderManager;

public class OfflineGame  extends Sprite{
    {CMI, Objective, Score, Core}
    public var socket:Socket;
    var t:TextField
    public function OfflineGame() {
        SCORMChannelKeys.SOCKET_KEY = SCORMChannelKeys.SOCKET_KEY+"3";
        SCORMChannelKeys.WRAPPER_KEY= SCORMChannelKeys.WRAPPER_KEY+"3";
        MonsterDebugger.initialize(this);
        DebuggerManager.initialize(MonsterDebugger.trace);
        EnvironmentManager.initialize(loaderInfo.url, "192.168.0.5");
        trace("asss")
        socket =  new Socket(PreloaderManager.setVisible);
        socket.addEventListener(ScormEventConnection.TYPE, onConnect);
        socket.addEventListener(ScormEventMessage.TYPE, onMessage);
        socket.addEventListener(ScormEventInitialize.TYPE, onInitialize);
        socket.addEventListener(ScormEventCommit.TYPE, onCommit);
        socket.addEventListener(ScormEventTerminate.TYPE, onTerminate);
        socket.findWrapper();
      t= new TextField();
        t.text="fffff";
        t.x = 100;
        t.y = 100;
        this.addChild(t);
    }
    private function onConnect(event : ScormEventConnection) : void {
        trace("\n connected - asdfasdfasdfa");
        t.text="conneted";
        socket.initialize();




    }


    private function onMessage(event : ScormEventMessage) : void {
        trace("\n" + event.msg);
    }

    private function onTerminate(event : ScormEventTerminate) : void {
        trace("\n TERMINATED");
    }

    private function onCommit(event : ScormEventCommit) : void {
        trace( "\n COMMITED");
        //scorm.terminate();
    }


    private function onInitialize(event : ScormEventInitialize) : void {
        DebuggerManager.debug("theLODED CMI",socket.cmi);
        trace("\n onInitialize - asdfasdfasdfa");
        socket.cmi.core.score.max="100";
        socket.cmi.core.score.min="0";
        socket.cmi.core.score.raw="75";
        socket.cmi.suspend_data= Math.random().toString();
        socket.cmi.core.lesson_status =SCORMLessonStatus.INCOMPLETE;
        var o:Objective= new Objective();
        o.id='0';
        o.score.raw="10";
        o.score.raw="10";
        o.score.raw="10";
        socket.cmi.objectives.push(o);
        socket.commit();

        // this.cmi.decodeJsonField(event._cmi);
        //this.txtReceive.text += "\n INICIALIZED";
    }
}
}
