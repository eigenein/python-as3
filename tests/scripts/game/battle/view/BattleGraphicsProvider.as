package game.battle.view
{
   import battle.data.BattleHeroDescription;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.skills.Effect;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import flash.utils.Dictionary;
   import game.assets.battle.BattleAsset;
   import game.assets.storage.RsxGameAsset;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   
   public class BattleGraphicsProvider
   {
       
      
      private var provider:BattleAsset;
      
      private var commonEffectsMap:Dictionary;
      
      private var createdAssets:Vector.<ClipAssetDataProvider>;
      
      public function BattleGraphicsProvider(param1:BattleAsset)
      {
         createdAssets = new Vector.<ClipAssetDataProvider>();
         super();
         this.provider = param1;
         commonEffectsMap = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = param1.commonAssets;
         for each(var _loc2_ in param1.commonAssets)
         {
            mapCommonEffects(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = createdAssets;
         for each(var _loc1_ in createdAssets)
         {
            _loc1_.dispose();
         }
         createdAssets.length = 0;
      }
      
      public function getHeroAsset(param1:BattleHeroDescription, param2:Number = 1, param3:String = null) : HeroClipAssetDataProvider
      {
         return provider.getHeroAssetClipProvider(param1,param2,param3);
      }
      
      public function getCommonEffect(param1:String) : EffectGraphicsProvider
      {
         return commonEffectsMap[param1.toLowerCase()];
      }
      
      public function getHeroEffect(param1:int, param2:String, param3:BattleHeroDescription, param4:Number, param5:String = null) : EffectGraphicsProvider
      {
         var _loc6_:String = BattleHeroEffectMapping.getAnimationByString(param2,param1);
         var _loc7_:HeroClipAssetDataProvider = provider.getHeroAssetClipProvider(param3,param4,param5);
         if(_loc6_ == null || _loc7_ == null)
         {
            return EffectGraphicsProvider.MISSING;
         }
         return _loc7_.getEffectProvider(_loc6_);
      }
      
      public function getOnHitEffect(param1:int, param2:BattleHeroDescription) : EffectGraphicsProvider
      {
         var _loc4_:* = null;
         var _loc3_:HeroClipAssetDataProvider = provider.getHeroAssetClipProvider(param2,1,"");
         if(_loc3_)
         {
            _loc4_ = BattleHeroEffectMapping.getAnimationByString(EffectAnimationIdent.HIT.name,param1);
            return _loc3_.getEffectProvider(_loc4_);
         }
         return EffectGraphicsProvider.MISSING;
      }
      
      public function getEffect(param1:String, param2:Effect, param3:Number) : EffectGraphicsProvider
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         assert(param1);
         assert(param2);
         if(param1 == EffectAnimationIdent.NONE.name)
         {
            return EffectGraphicsProvider.MISSING;
         }
         if(param2)
         {
            if(param1 == EffectAnimationIdent.COMMON.name)
            {
               param1 = param2.ident.toLowerCase();
               return !!commonEffectsMap[param1]?commonEffectsMap[param1]:EffectGraphicsProvider.MISSING;
            }
            if(param2.skillCast.skill != null)
            {
               _loc5_ = param2.skillCast.skill.tier;
               if(_loc5_ <= HeroAnimationIdent.ANIMATED_TIER)
               {
                  _loc4_ = BattleHeroEffectMapping.getAnimationByString(param1,_loc5_);
                  _loc6_ = provider.getHeroAssetClipProvider(param2.skillCast.skill.hero,param3);
               }
            }
            if(_loc4_ && EffectGraphicsProvider.hasFx(_loc6_,_loc4_))
            {
               return _loc6_.getEffectProvider(_loc4_);
            }
            param1 = param2.ident.toLowerCase();
            return !!commonEffectsMap[param1]?commonEffectsMap[param1]:EffectGraphicsProvider.MISSING;
         }
         assert(false);
         return EffectGraphicsProvider.MISSING;
      }
      
      protected function mapCommonEffects(param1:RsxGameAsset) : void
      {
         var _loc4_:* = null;
         var _loc2_:ClipAssetDataProvider = new ClipAssetDataProvider(param1.data,1);
         var _loc3_:HeroClipAssetDataProvider = new HeroClipAssetDataProvider(_loc2_,false,"",1);
         createdAssets.push(_loc2_);
         var _loc7_:int = 0;
         var _loc6_:* = param1.data.clips;
         for each(var _loc5_ in param1.data.clips)
         {
            _loc4_ = EffectGraphicsProvider.getFxName(_loc5_.className).toLowerCase();
            commonEffectsMap[_loc4_] = new EffectGraphicsProvider(_loc3_,_loc4_);
         }
      }
   }
}
