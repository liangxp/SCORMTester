/**
 * Created with IntelliJ IDEA.
 * User: filipe
 * Date: 06/02/13
 * Time: 23:29
 * To change this template use File | Settings | File Templates.
 */
package offlineGame {
import com.demonsters.debugger.MonsterDebugger;
import com.fraktalo.SCORM.SCORMLessonStatus;
import com.fraktalo.SCORM.Socket;
import com.fraktalo.SCORM.events.ScormEventCommit;
import com.fraktalo.SCORM.events.ScormEventConnection;
import com.fraktalo.SCORM.events.ScormEventInitialize;
import com.fraktalo.SCORM.events.ScormEventMessage;
import com.fraktalo.SCORM.events.ScormEventTerminate;

import flash.display.Sprite;

import managers.DebuggerManager;
import managers.EnvironmentManager;

import preloader.PreloaderManager;

public class OfflineGame  extends Sprite{
    public var socket:Socket;
    public function OfflineGame() {
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
    }
    private function onConnect(event : ScormEventConnection) : void {
        trace("\n connected - asdfasdfasdfa");
        socket.initialize();
        //scorm .initialize();
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
        trace("\n onInitialize - asdfasdfasdfa");
        socket.cmi.core.score.max="100";
        socket.cmi.core.score.min="0";
        socket.cmi.core.score.raw="35";
        socket.cmi.suspend_data= "adsfasdfasdfasdfasdfasdfadfasdfasdf";
        socket.cmi.core.lesson_status =SCORMLessonStatus.COMPLETED;
        socket.commit();

        // this.cmi.decodeJsonField(event._cmi);
        //this.txtReceive.text += "\n INICIALIZED";
    }
}
}
