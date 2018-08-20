package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class ExpeditionBriefingPopupRarityClip extends GuiClipNestedContainer
   {
       
      
      public const rarity:Vector.<GuiClipScale3Image> = new Vector.<GuiClipScale3Image>();
      
      public function ExpeditionBriefingPopupRarityClip()
      {
         super();
      }
      
      public function setRarity(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Boolean = param1 > 0 && param1 < rarity.length;
         if(!_loc2_)
         {
            param1 = 0;
         }
         var _loc3_:int = rarity.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            rarity[_loc4_].graphics.visible = _loc4_ == param1;
            _loc4_++;
         }
      }
   }
}
