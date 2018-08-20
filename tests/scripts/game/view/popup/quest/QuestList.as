package game.view.popup.quest
{
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class QuestList extends GameScrolledList
   {
       
      
      public function QuestList(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super(param1,param2,param3);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         var _loc2_:int = 20;
         _loc1_.paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
         layout = _loc1_;
         _loc1_.gap = 10;
      }
   }
}
