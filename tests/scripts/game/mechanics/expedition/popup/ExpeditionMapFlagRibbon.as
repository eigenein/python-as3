package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ExpeditionMapFlagRibbon extends GuiClipNestedContainer
   {
       
      
      public const rarity:Vector.<ExpeditionMapFlagRibbonColor> = new Vector.<ExpeditionMapFlagRibbonColor>();
      
      public function ExpeditionMapFlagRibbon()
      {
         super();
      }
      
      public function setRarity(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = param1 > 0 && param1 < rarity.length;
         if(!_loc3_)
         {
            param1 = 0;
         }
         var _loc4_:int = rarity.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            rarity[_loc5_].setStatus(param2);
            rarity[_loc5_].graphics.visible = _loc5_ == param1;
            _loc5_++;
         }
      }
   }
}
