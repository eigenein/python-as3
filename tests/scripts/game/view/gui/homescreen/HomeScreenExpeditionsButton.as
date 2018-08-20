package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import flash.geom.Point;
   import game.mechanics.zeppelin.mediator.ZeppelinPopupMediator;
   import starling.events.EnterFrameEvent;
   
   public class HomeScreenExpeditionsButton extends HomeScreenBuildingButton
   {
       
      
      public var button:HomeScreenExpeditionsButtonZeppelinClip;
      
      private var time:Number = 0;
      
      private var base:Point;
      
      public function HomeScreenExpeditionsButton()
      {
         button = new HomeScreenExpeditionsButtonZeppelinClip();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         animation = button.animation;
         hitTest_image = button.hitTest_image;
         hover_front = button.hover_front;
         super.setNode(param1);
         base = new Point(button.graphics.x,button.graphics.y);
         graphics.addEventListener("enterFrame",handler_enterFrame);
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return ZeppelinPopupMediator.music;
      }
      
      private function handler_enterFrame(param1:EnterFrameEvent) : void
      {
         time = time + param1.passedTime;
         button.graphics.x = base.x + Math.sin(time / 3) * 4;
         button.graphics.y = base.y + Math.sin(time) * 3;
      }
   }
}
