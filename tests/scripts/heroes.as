package
{
   import battle.utils.Version;
   import com.progrestar.common.error.ClientErrorManager;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import engine.context.GameContext;
   import engine.context.platform.social.FBSocialFacadeHelper;
   import engine.loader.ClientVersion;
   import engine.loader.SVNProps;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import game.battle.BattleLogEncoder;
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.stat.Stash;
   import game.util.SessionStateInfoProvider;
   import starling.core.Starling;
   import starling.display.BlendMode;
   import starling.events.Event;
   
   public class heroes extends flash.display.Sprite
   {
      
      public static const SVN_PROPS:SVNProps = new SVNProps();
       
      
      private var _starling:Starling;
      
      public function heroes()
      {
         var _loc1_:* = null;
         super();
         SVN_PROPS.DATE = "$Date: 2018-07-20 14:04:11 +0300 (Пт, 20 июл 2018) $";
         SVN_PROPS.REVISION = "$Revision: 6672 $";
         SVN_PROPS.URL = "$URL: https://svn-local.studionx.ru/heroes_client/src_web/trunk/heroes.as $";
         if(ExternalInterfaceProxy.available)
         {
            ExternalInterfaceProxy.call("window.feedback.setGameClientVersion",heroes.SVN_PROPS.revision + " assets: " + GameContext.instance.assetIndex.version);
         }
         trace(SVN_PROPS.svnInfoString);
         allowDomains();
         initDictionaryToJSON();
         initHaxe();
         new BattleLogEncoder();
         ClipImageCache.errorHandler = ClientErrorManager.action_handleError;
         if(Capabilities.playerType == "StandAlone" && stage)
         {
            _loc1_ = SVN_PROPS.createTextField();
            _loc1_.text = _loc1_.text + (" " + Version.last);
            stage.addChild(_loc1_);
         }
      }
      
      public function run(param1:GameContext, param2:starling.display.Sprite = null) : void
      {
         stage.color = 0;
         if(param2)
         {
            GameTimer.instance.init(Starling.current.nativeStage);
         }
         else
         {
            GameTimer.instance.init(stage);
         }
         if(param1 && param1.libStaticData && param1.libStaticData.rule && param1.libStaticData.rule.useAdaptiveTimer !== undefined)
         {
            GameTimer.instance.useAdaptiveTimer = param1.libStaticData.rule.useAdaptiveTimer;
         }
         GameModel.instance.context = param1;
         GameModel.instance.init();
         if(param2)
         {
            _starling = Starling.current;
            param2.addChildAt(new Game(),0);
            _starling.showStats = true;
         }
         else
         {
            initStarling();
         }
         ClientVersion.game_ver = SVN_PROPS.svnInfoString;
         Stash.sendClientStat(".user.completeLoading");
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            Stash.sendClientStat(".client.fbPromotion",{"isEligiblePromo":FBSocialFacadeHelper.fbPromoEnabled});
         }
         _starling.stage.addEventListener("resize",handler_stageResize);
      }
      
      private function handler_stageResize(param1:Event, param2:Point) : void
      {
         var _loc3_:Number = Math.min(param2.x,2048);
         var _loc8_:Number = Math.min(param2.y,2048);
         var _loc6_:Number = _loc3_ / 1000;
         var _loc7_:Number = _loc8_ / 640;
         if(_loc7_ < _loc6_)
         {
            _loc3_ = _loc3_ * (_loc7_ / _loc6_);
         }
         else
         {
            _loc8_ = _loc8_ * (_loc6_ / _loc7_);
         }
         var _loc4_:int = (param2.x - _loc3_) * 0.5;
         var _loc5_:int = (param2.y - _loc8_) * 0.5;
         Starling.current.viewPort.setTo(_loc4_,_loc5_,_loc3_,_loc8_);
      }
      
      private function initStarling() : void
      {
         BlendMode.register("overlay","destinationColor","destinationAlpha");
         BlendMode.register("alpha","sourceAlpha","oneMinusSourceAlpha");
         var _loc3_:int = 1000;
         var _loc5_:int = 640;
         var _loc4_:int = Math.min(_loc3_,stage.stageWidth);
         var _loc2_:int = _loc4_ * (_loc5_ / _loc3_);
         var _loc6_:Rectangle = new Rectangle(0,0,_loc4_,_loc2_);
         Starling.handleLostContext = true;
         _starling = new Starling(Game,stage,_loc6_);
         _starling.stage.stageHeight = _loc5_;
         _starling.stage.stageWidth = _loc3_;
         _starling.start();
         var _loc1_:SessionStateInfoProvider = new SessionStateInfoProvider(_starling);
         ClientErrorManager.instance.addSessionStateInfoProvider(_loc1_);
      }
      
      private function allowDomains() : void
      {
         try
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            return;
         }
         catch(e:*)
         {
            trace("heroes::allowDomains"," e=",e);
            return;
         }
      }
      
      private function initDictionaryToJSON() : void
      {
         Dictionary.prototype.toJSON = function(param1:String):*
         {
            var _loc2_:Object = {};
            var _loc5_:int = 0;
            var _loc4_:* = this;
            for(var _loc3_ in this)
            {
               _loc2_[_loc3_] = this[_loc3_];
            }
            return _loc2_;
         };
      }
      
      private function initHaxe() : void
      {
         haxe.initSwc(null);
      }
   }
}
