package game.view.gui.components
{
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.view.popup.mission.MissionEnterPopupEnemyRenderer;
   
   public class TeamView extends List
   {
       
      
      private var reversedOrder:Boolean = false;
      
      public function TeamView()
      {
         super();
      }
      
      public function set team(param1:Vector.<HeroEntryValueObject>) : void
      {
         if(param1)
         {
            param1.sort(!!reversedOrder?HeroEntryValueObject.sortReversed:HeroEntryValueObject.sort);
         }
         dataProvider = new ListCollection(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 0;
         itemRendererType = MissionEnterPopupEnemyRenderer;
         layout = _loc1_;
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "off";
      }
   }
}
