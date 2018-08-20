package game.view.popup.hero.rune
{
   import game.mediator.gui.popup.rune.PlayerHeroRuneValueObject;
   
   public class RuneItemSmallClip extends RuneItemClip
   {
       
      
      public function RuneItemSmallClip()
      {
         super();
         isEnabled = false;
      }
      
      override public function setData(param1:PlayerHeroRuneValueObject) : void
      {
         var _loc3_:Boolean = param1 == null || param1.locked;
         var _loc2_:Boolean = param1 && param1.level > 0;
         tf_level.text = String(param1.level);
         updateFilter(_loc3_,_loc2_);
         tf_level.visible = !_loc3_;
         lock_icon.graphics.visible = _loc3_;
         if(param1)
         {
            image_container.removeChildren(0,-1,true);
            setupIcon(param1);
         }
         this._data = param1;
      }
      
      override protected function setupIcon(param1:PlayerHeroRuneValueObject) : void
      {
         image_container.addChild(param1.createIconSpriteSmall().graphics);
         image_container.validate();
      }
   }
}
