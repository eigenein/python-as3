package game.view.gui.homescreen
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.rpc.ny.NYFireworksLaunchPersonVO;
   import game.model.GameModel;
   import game.model.user.ClanUserInfoValueObject;
   import game.model.user.specialoffer.NY2018SecretRewardOfferViewOwner;
   import game.view.popup.chest.SoundGuiAnimation;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class HomeScreenSceneNYFireworks
   {
      
      private static var _instance:HomeScreenSceneNYFireworks;
       
      
      private var queue:Vector.<NYFireworksLaunchPersonVO>;
      
      private var sky:HomeScreenZeppelinLayerGuiClip;
      
      private var ground:HomeScreenGuiClip;
      
      protected var asset:RsxGuiAsset;
      
      protected var loaded:Boolean;
      
      private var clip_front:SoundGuiAnimation;
      
      private var clip_back:SoundGuiAnimation;
      
      private var nameplate:HomeScreenSceneNyFireworksNamePlate;
      
      private var nameplateTween:Tween;
      
      public function HomeScreenSceneNYFireworks(param1:HomeScreenZeppelinLayerGuiClip, param2:HomeScreenGuiClip)
      {
         queue = new Vector.<NYFireworksLaunchPersonVO>();
         super();
         _instance = this;
         this.ground = param2;
         this.sky = param1;
      }
      
      public static function get instance() : HomeScreenSceneNYFireworks
      {
         return _instance;
      }
      
      protected function get progressAsset() : RequestableAsset
      {
         return asset;
      }
      
      public function action_launch(param1:NYFireworksLaunchPersonVO, param2:Boolean) : void
      {
         queue.push(param1);
         if(loaded)
         {
            launchNext();
         }
         else
         {
            load(param2);
         }
      }
      
      protected function load(param1:Boolean) : void
      {
         asset = AssetStorage.rsx.getByName("ny_fireworks") as RsxGuiAsset;
         if(progressAsset)
         {
            if(param1)
            {
               AssetStorage.battle.requestAssetWithPreloader(progressAsset,handler_assetLoaded);
            }
            else
            {
               AssetStorage.instance.globalLoader.requestAssetWithCallback(progressAsset,handler_assetLoaded);
            }
         }
         else
         {
            handler_assetLoaded(null);
         }
      }
      
      private function interrupt() : void
      {
         if(clip_front)
         {
            clip_front.signal_completed.remove(handler_completed);
            if(clip_front.graphics.parent)
            {
               clip_front.graphics.removeFromParent(true);
            }
            clip_front = null;
         }
         if(clip_back)
         {
            if(clip_back.graphics.parent)
            {
               clip_back.graphics.removeFromParent(true);
            }
            clip_back = null;
         }
         if(nameplate)
         {
            if(nameplate.graphics.parent)
            {
               nameplate.graphics.removeFromParent(true);
            }
            nameplate = null;
         }
         if(nameplateTween)
         {
            Starling.juggler.remove(nameplateTween);
            nameplateTween = null;
         }
      }
      
      private function launchNext() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(queue.length)
         {
            interrupt();
            _loc2_ = queue.shift();
            clip_front = asset.create(SoundGuiAnimation,"FRVAnimFront");
            clip_front.graphics.touchable = false;
            clip_back = asset.create(SoundGuiAnimation,"FRVAnimBack");
            clip_back.graphics.touchable = false;
            nameplate = asset.create(HomeScreenSceneNyFireworksNamePlate,"nameplate");
            ground.container.addChild(nameplate.graphics);
            nameplate.graphics.alpha = 0;
            nameplateTween = Starling.juggler.tween(nameplate.graphics,0.5,{"alpha":1}) as Tween;
            nameplate.graphics.x = 320;
            nameplate.graphics.y = 395;
            if(_loc2_.clanIcon)
            {
               _loc1_ = new ClanUserInfoValueObject();
               _loc1_.setupFromArguments(_loc2_.clanId,_loc2_.clanTitle,_loc2_.clanIcon);
               nameplate.clan_icon.setData(_loc1_,false);
               nameplate.tf_clan_title.text = Translate.translateArgs("UI_NAMEPLATE_TF_CLAN_TITLE",_loc2_.clanTitle);
               try
               {
                  if(GameModel.instance.player.specialOffer.hasSpecialOffer("ny2k18secretReward"))
                  {
                     nameplate.graphics.touchable = true;
                  }
                  GameModel.instance.player.specialOffer.hooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(nameplate.layout_secret,this,"fireworks"));
               }
               catch(error:Error)
               {
               }
            }
            else
            {
               nameplate.tf_clan_title.visible = false;
               nameplate.clan_icon_bg.graphics.visible = false;
            }
            nameplate.tf_label.text = Translate.translate("UI_NAMEPLATE_TF_LABEL");
            if(_loc2_.nickname)
            {
               nameplate.tf_name.text = _loc2_.nickname;
            }
            else
            {
               nameplate.tf_name.text = Translate.translate("UI_NAMEPLATE_TF_ANONYMOUS");
            }
            sky.container.addChild(clip_back.graphics);
            ground.container.addChild(clip_front.graphics);
            clip_front.playOnce();
            clip_front.signal_completed.add(handler_completed);
         }
      }
      
      private function handler_completed() : void
      {
         interrupt();
      }
      
      protected function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         loaded = true;
         launchNext();
      }
   }
}
