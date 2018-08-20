package game.view.popup.test
{
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipListItem;
   import idv.cjcat.signals.Signal;
   
   public class BattleTestStatsBattlegroundListItem extends ClipListItem
   {
       
      
      private var data:BattleTestStatsBattlegroundValueObject;
      
      private const _signal_select:Signal = new Signal(Object);
      
      public var button:ClipButtonLabeled;
      
      public var selected:ClipSprite;
      
      public function BattleTestStatsBattlegroundListItem()
      {
         button = new ClipButtonLabeled();
         super();
         button.signal_click.add(handler_click);
      }
      
      override public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function setData(param1:*) : void
      {
         this.data = param1 as BattleTestStatsBattlegroundValueObject;
         if(this.data)
         {
            button.label = this.data.name;
         }
         else
         {
            button.label = "";
         }
      }
      
      override public function setSelected(param1:Boolean) : void
      {
         selected.graphics.visible = param1;
      }
      
      private function handler_click() : void
      {
         _signal_select.dispatch(data);
      }
   }
}
