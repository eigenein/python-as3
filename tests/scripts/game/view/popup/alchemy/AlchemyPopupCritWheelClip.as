package game.view.popup.alchemy
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.sound.SoundSource;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.chest.SoundGuiAnimation;
   import idv.cjcat.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class AlchemyPopupCritWheelClip extends GuiClipNestedContainer
   {
       
      
      private var crit:int;
      
      private var targetSector:AlchemyPopupCritWheelFaceSectorClip;
      
      private var alchemyWheelSound:SoundSource;
      
      public var super_animation:SoundGuiAnimation;
      
      private var _signal_rewardRollComplete:Signal;
      
      public var tf_gold:ClipLabel;
      
      public var crit_wheel_face:AlchemyPopupCritWheelFaceClip;
      
      public var frame:ClipSprite;
      
      private var _wheelRotation:Number = 0;
      
      public function AlchemyPopupCritWheelClip()
      {
         super_animation = new SoundGuiAnimation();
         _signal_rewardRollComplete = new Signal();
         tf_gold = new ClipLabel();
         crit_wheel_face = new AlchemyPopupCritWheelFaceClip();
         frame = new ClipSprite();
         super();
      }
      
      public function get signal_rewardRollComplete() : Signal
      {
         return _signal_rewardRollComplete;
      }
      
      public function get wheelRotation() : Number
      {
         return _wheelRotation;
      }
      
      public function set wheelRotation(param1:Number) : void
      {
         crit_wheel_face.graphics.rotation = param1;
         if(_wheelRotation == param1)
         {
            return;
         }
         _wheelRotation = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         super_animation.hide();
      }
      
      public function rotateTo(param1:int) : void
      {
         var _loc5_:int = 0;
         this.crit = param1;
         alchemyWheelSound = AssetStorage.sound.alchemyWheel;
         alchemyWheelSound.play();
         Starling.juggler.removeTweens(this);
         var _loc8_:int = 3;
         var _loc4_:int = crit_wheel_face.sector.length;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(crit_wheel_face.sector[_loc5_].data.crit == param1)
            {
               _loc3_.push(_loc5_);
            }
            crit_wheel_face.sector[_loc5_].highlight = false;
            _loc5_++;
         }
         var _loc6_:int = Math.random() * _loc3_.length;
         _loc6_ = _loc3_[_loc6_];
         targetSector = crit_wheel_face.sector[_loc6_];
         _wheelRotation = _wheelRotation % (3.14159265358979 * 2) - 3.14159265358979 * 4 * _loc8_ * 2;
         var _loc7_:Number = 3.14159265358979 * crit_wheel_face.sector[_loc6_].data.angle / 180;
         var _loc2_:* = 6;
         var _loc9_:* = 0.1;
         Starling.juggler.tween(this,_loc2_,{
            "wheelRotation":_loc7_ + 0.502654824574367 * (Math.random() - 0.5),
            "transition":"easeOut",
            "onComplete":handler_firstTweenComplete
         }) as Tween;
      }
      
      private function handler_firstTweenComplete() : void
      {
         super_animation.show(container);
         super_animation.playOnceAndHide();
         _signal_rewardRollComplete.dispatch();
         if(targetSector)
         {
            targetSector.highlight = true;
         }
         targetSector = null;
      }
      
      public function dispose() : void
      {
         if(alchemyWheelSound)
         {
            alchemyWheelSound.stop();
         }
         Starling.juggler.removeTweens(this);
      }
   }
}
