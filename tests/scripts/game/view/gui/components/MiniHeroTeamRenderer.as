package game.view.gui.components
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.view.gui.components.hero.MiniHeroPortraitClipWithLevel;
   
   public class MiniHeroTeamRenderer extends GuiClipNestedContainer
   {
       
      
      private var _reversed:Boolean;
      
      public var hero:Vector.<MiniHeroPortraitClipWithLevel>;
      
      public function MiniHeroTeamRenderer()
      {
         hero = new Vector.<MiniHeroPortraitClipWithLevel>();
         super();
      }
      
      public function set reversed(param1:Boolean) : void
      {
         this._reversed = param1;
      }
      
      public function setTeam(param1:Vector.<HeroEntryValueObject>) : void
      {
         _setTeam(UnitUtils.heroEntryVectorToUnitEntryVector(param1));
      }
      
      public function setUnitTeam(param1:Vector.<UnitEntryValueObject>) : void
      {
         _setTeam(param1.concat());
      }
      
      protected function _setTeam(param1:Vector.<UnitEntryValueObject>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         param1.sort(sort_byBattleOrder);
         if(_reversed)
         {
            _loc3_ = -1;
            _loc2_ = hero.length - 1;
         }
         else
         {
            _loc3_ = 1;
            _loc2_ = 0;
         }
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = hero[_loc2_ + _loc3_ * _loc5_];
            _loc6_.data = param1[_loc5_];
            _loc6_.isEnabled = false;
            _loc5_++;
         }
         _loc4_ = hero.length;
         while(_loc5_ < _loc4_)
         {
            hero[_loc2_ + _loc3_ * _loc5_].data = null;
            _loc5_++;
         }
      }
      
      private function sort_byBattleOrder(param1:UnitEntryValueObject, param2:UnitEntryValueObject) : int
      {
         return param1.unit.battleOrder - param2.unit.battleOrder;
      }
   }
}
