package game.view.popup.test.battlelist
{
   import game.mediator.gui.popup.mission.TestBattleListValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class BattleTestListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:BattleTestListItemClip;
      
      private var vo:TestBattleListValueObject;
      
      public function BattleTestListItemRenderer(param1:BattleTestListItemClip)
      {
         super();
         addChild(param1.graphics);
         this.clip = param1;
         param1.signal_click.add(handler_click);
      }
      
      override protected function commitData() : void
      {
         if(vo != _data)
         {
            if(vo)
            {
               clearData();
            }
            vo = _data as TestBattleListValueObject;
            if(vo)
            {
               setupData();
            }
            else
            {
               noData();
            }
         }
      }
      
      protected function noData() : void
      {
      }
      
      protected function clearData() : void
      {
         vo.completed.unsubscribe(handler_completed);
         vo.failed.unsubscribe(handler_failed);
      }
      
      protected function setupData() : void
      {
         vo.completed.onValue(handler_completed);
         vo.failed.onValue(handler_failed);
         clip.label = vo.d.id + " " + vo.name;
         clip.icon_check.graphics.visible = false;
         clip.icon_off.graphics.visible = false;
         clip.icon_on.graphics.visible = false;
      }
      
      private function handler_completed(param1:Boolean) : void
      {
         clip.icon_check.graphics.visible = param1;
      }
      
      private function handler_failed(param1:Boolean) : void
      {
         clip.icon_off.graphics.visible = param1;
      }
      
      private function handler_click() : void
      {
         if(vo)
         {
            vo.action_select();
         }
      }
   }
}
