package game.view.popup.test
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ClipCounters extends GuiClipNestedContainer
   {
       
      
      public var label_battles_started:ClipLabel;
      
      public var label_battles_started_value:ClipLabel;
      
      public var label_battles_succeeded:ClipLabel;
      
      public var label_battles_succeeded_value:ClipLabel;
      
      public var label_battles_bad:ClipLabel;
      
      public var label_battles_bad_value:ClipLabel;
      
      public var label_durations_report:ClipLabel;
      
      public function ClipCounters()
      {
         super();
      }
      
      public function setCounters(param1:int, param2:int, param3:int) : void
      {
         label_battles_started_value.text = String(param1);
         label_battles_succeeded_value.text = String(param2);
         label_battles_bad_value.text = String(param3);
      }
   }
}
