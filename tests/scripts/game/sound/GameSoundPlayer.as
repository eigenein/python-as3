package game.sound
{
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import game.assets.storage.AssetStorage;
   import game.model.GameModel;
   
   public class GameSoundPlayer implements IClipSoundEventHandler
   {
      
      public static const GUI_VOLUME:Number = 0.3;
      
      public static const GUI_CLICK_VOLUME:Number = 1;
       
      
      public const music:SoundManager = new SoundManager();
      
      public function GameSoundPlayer()
      {
         super();
      }
      
      protected function get settingsSoundVolume() : Number
      {
         return GameModel.instance.player.settings.soundsVolume.getValue();
      }
      
      public function onSoundEvent(param1:ClipSoundEvent) : void
      {
         var _loc2_:* = null;
         if(GameModel.instance.player.settings.playSounds.getValue())
         {
            _loc2_ = new SoundTransform(0.3 * settingsSoundVolume);
            param1.sound.sound.play(0,0,_loc2_);
         }
      }
      
      public function playClipSound(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(GameModel.instance.player.settings.playSounds.getValue())
         {
            _loc4_ = AssetStorage.rsx.popup_theme.getSound(param1);
            if(_loc4_ && _loc4_.sound)
            {
               _loc2_ = new SoundTransform(0.3 * settingsSoundVolume);
               _loc3_ = _loc4_.sound.play(0,0,_loc2_);
            }
         }
      }
      
      public function playDefaultClickSound() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:String = "click_v5_2ch_21db";
         if(GameModel.instance.player.settings.playSounds.getValue())
         {
            _loc3_ = AssetStorage.rsx.popup_theme.getSound(_loc4_);
            if(_loc3_ && _loc3_.sound)
            {
               _loc1_ = new SoundTransform(1 * settingsSoundVolume);
               _loc2_ = _loc3_.sound.play(30,0,_loc1_);
            }
         }
      }
   }
}
