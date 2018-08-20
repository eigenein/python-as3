package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ImageWithUniqueTexture;
   import starling.display.Image;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class ImprovementRenderer4 extends ImprovementRenderer
   {
       
      
      public var title_tf:ClipLabel;
      
      public var activity_tf:ClipLabel;
      
      public var today_tf:ClipLabel;
      
      public function ImprovementRenderer4()
      {
         title_tf = new ClipLabel();
         activity_tf = new ClipLabel();
         today_tf = new ClipLabel(true);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         label_desc.text = Translate.translate("UI_DIALOG_DEFEAT_RUNES_DESC");
         title_tf.text = Translate.translate("UI_CLAN_FORGE_BUTTON_TF_FORGE");
         activity_tf.text = Translate.translate("UI_DIALOG_CLAN_INFO_PERSON_ACTIVITY");
         today_tf.text = Translate.translate("UI_DIALOG_CLAN_INFO_TODAY");
         today_tf.validate();
         container.addChild(createUnderline());
      }
      
      private function createUnderline() : Image
      {
         var _loc4_:* = 0.0872664625997165;
         var _loc5_:Number = today_tf.width * Math.cos(_loc4_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,1);
         _loc2_.graphics.drawRect(0,0,_loc5_,2);
         _loc2_.graphics.endFill();
         var _loc6_:Matrix = new Matrix();
         _loc6_.rotate(_loc4_);
         var _loc3_:BitmapData = new BitmapData(Math.cos(_loc4_) * _loc5_,today_tf.height,true,0);
         _loc3_.draw(_loc2_,_loc6_);
         var _loc1_:ImageWithUniqueTexture = new ImageWithUniqueTexture(Texture.fromBitmapData(_loc3_));
         TextureMemoryManager.add(_loc1_.texture,"ImprovementRenderer4");
         _loc1_.x = today_tf.x - 1;
         _loc1_.y = today_tf.y + 17;
         return _loc1_;
      }
   }
}
