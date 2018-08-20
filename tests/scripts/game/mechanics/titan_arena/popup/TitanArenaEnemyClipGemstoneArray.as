package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class TitanArenaEnemyClipGemstoneArray extends GuiClipNestedContainer
   {
       
      
      public var gem:Vector.<GuiClipContainer>;
      
      public function TitanArenaEnemyClipGemstoneArray()
      {
         gem = new Vector.<GuiClipContainer>();
         super();
      }
      
      public function setTeam(param1:Vector.<UnitEntryValueObject>, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:Vector.<UnitEntryValueObject> = param1.concat();
         _loc6_.sort(sort_byBattleOrder);
         var _loc3_:int = gem.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            gem[_loc5_].container.removeChildren();
            _loc7_ = "grey";
            if(_loc6_ && _loc6_.length > _loc5_ && !param2)
            {
               _loc4_ = (_loc6_[_loc5_].unit as TitanDescription).details.element;
               var _loc8_:* = _loc4_;
               if("earth" !== _loc8_)
               {
                  if("fire" !== _loc8_)
                  {
                     if("water" === _loc8_)
                     {
                        _loc7_ = "blue";
                     }
                  }
                  else
                  {
                     _loc7_ = "red";
                  }
               }
               else
               {
                  _loc7_ = "green";
               }
            }
            gem[_loc5_].container.addChild((AssetStorage.rsx.dialog_titan_arena.create(ClipSprite,"jewel_" + _loc7_) as ClipSprite).graphics);
            _loc5_++;
         }
      }
      
      private function sort_byBattleOrder(param1:UnitEntryValueObject, param2:UnitEntryValueObject) : int
      {
         return param1.unit.battleOrder - param2.unit.battleOrder;
      }
   }
}
