package game.view.gui.components
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.hero.MiniHeroPortraitClipWithLevelAndHP;
   
   public class MiniHeroTeamRendererWithHP extends GuiClipNestedContainer
   {
       
      
      private var _reversed:Boolean;
      
      public var hero:Vector.<MiniHeroPortraitClipWithLevelAndHP>;
      
      public function MiniHeroTeamRendererWithHP()
      {
         hero = new Vector.<MiniHeroPortraitClipWithLevelAndHP>();
         super();
      }
      
      public function set reversed(param1:Boolean) : void
      {
         this._reversed = param1;
      }
      
      public function setUnitTeam(param1:Vector.<UnitEntryValueObject>, param2:Vector.<Number>) : void
      {
         _setTeam(param1.concat(),param2.concat());
      }
      
      protected function _setTeam(param1:Vector.<UnitEntryValueObject>, param2:Vector.<Number>) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc7_:Array = [];
         var _loc5_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_.push({
               "unit":param1[_loc6_],
               "hp":param2[_loc6_]
            });
            _loc6_++;
         }
         _loc7_.sort(sort_compilation_byBattleOrder);
         if(_reversed)
         {
            _loc4_ = -1;
            _loc3_ = hero.length - 1;
         }
         else
         {
            _loc4_ = 1;
            _loc3_ = 0;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = hero[_loc3_ + _loc4_ * _loc6_];
            if(_loc7_[_loc6_])
            {
               _loc8_.data = _loc7_[_loc6_].unit;
               _loc8_.setHPPercent(_loc7_[_loc6_].hp);
            }
            else
            {
               _loc8_.data = null;
               _loc8_.setHPPercent(NaN);
            }
            _loc8_.isEnabled = false;
            _loc6_++;
         }
         _loc5_ = hero.length;
         while(_loc6_ < _loc5_)
         {
            hero[_loc3_ + _loc4_ * _loc6_].data = null;
            _loc6_++;
         }
      }
      
      private function sort_compilation_byBattleOrder(param1:Object, param2:Object) : int
      {
         return sort_byBattleOrder(param1.unit,param2.unit);
      }
      
      private function sort_byBattleOrder(param1:UnitEntryValueObject, param2:UnitEntryValueObject) : int
      {
         return param1.unit.battleOrder - param2.unit.battleOrder;
      }
   }
}
