package game.mechanics.titan_arena.popup
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupButton;
   
   public class TitanValleyPopupSpiritButton extends ZeppelinPopupButton
   {
       
      
      public var spirit:TitanValleySpiritClip;
      
      public function TitanValleyPopupSpiritButton()
      {
         super();
      }
      
      public function setEvolution(param1:String) : void
      {
         if(spirit)
         {
            container.removeChild(spirit.graphics,true);
            spirit = null;
         }
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName("big_pillars") as RsxGuiAsset;
         spirit = _loc2_.create(TitanValleySpiritClip,param1) as TitanValleySpiritClip;
         var _loc3_:* = 0.74;
         spirit.graphics.scaleY = _loc3_;
         spirit.graphics.scaleX = _loc3_;
         container.addChildAt(spirit.graphics,0);
         hitTest_image = spirit.hitTest_image;
         animation = spirit.animation;
         hover_front = spirit.hover_front;
         animation.graphics.touchable = false;
         hover_front.graphics.touchable = false;
         hoverAnimationIntensity = 0;
         adjustIntensity(hover_front,0);
      }
   }
}
