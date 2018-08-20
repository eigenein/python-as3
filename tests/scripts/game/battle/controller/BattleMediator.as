package game.battle.controller
{
   import battle.BattleEngine;
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import battle.objects.BattleBody;
   import battle.objects.EffectHolder;
   import battle.objects.ProjectileEntity;
   import battle.proxy.IBattleBodyProxy;
   import battle.proxy.ISceneProxy;
   import battle.proxy.ViewPosition;
   import battle.proxy.ViewTransform;
   import battle.proxy.ViewTransformProvider;
   import battle.proxy.displayEvents.BattleDisplayEvent;
   import battle.proxy.displayEvents.BattleTextEvent;
   import battle.proxy.displayEvents.CustomAbilityEvent;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import battle.proxy.displayEvents.GuiFxEvent;
   import battle.proxy.displayEvents.SimpleFxEvent;
   import battle.proxy.displayEvents.TeamEffectEvent;
   import battle.proxy.displayEvents.TeamUltAnimationEvent;
   import battle.proxy.displayEvents.TitanArtifactGuiFxEvent;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   import flash.geom.Matrix;
   import game.battle.controller.entities.BattleEffect;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.entities.BattleProjectile;
   import game.battle.controller.position.BattleBodyEntry;
   import game.battle.gui.teamskill.TitanArtifactBattleGuiFx;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.BattleGraphicsProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.BattleFx;
   import game.battle.view.animation.ComplexAnimation;
   import game.battle.view.animation.TiledFxAnimation;
   import game.battle.view.ult.UltAnimationCast;
   import game.data.storage.DataStorage;
   import org.osflash.signals.Signal;
   
   public class BattleMediator implements ISceneProxy
   {
       
      
      private var objects:BattleMediatorObjects;
      
      private var asset:BattleGraphicsProvider;
      
      private var graphics:BattleGraphicsMethodProvider;
      
      public const signal_displayEvent:Signal = new Signal(BattleDisplayEvent);
      
      public function BattleMediator(param1:BattleMediatorObjects, param2:BattleGraphicsProvider, param3:BattleGraphicsMethodProvider)
      {
         super();
         this.objects = param1;
         this.asset = param2;
         this.graphics = param3;
      }
      
      public function addHero(param1:Hero) : void
      {
         var _loc4_:BattleHero = objects.getHeroByDescription(param1.desc);
         if(_loc4_ == null)
         {
            _loc4_ = new BattleHero(param1.desc,objects,graphics);
         }
         _loc4_.updateGraphicsMethodProvider(graphics);
         objects.entities.add(param1,_loc4_);
         var _loc2_:Vector.<Effect> = param1.effects.effects;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            trace("Effect был создан до создания героя. Этот кейс долгое время обрабатывался ошибочно (никак)");
            addEffect(_loc3_,param1);
         }
      }
      
      private function getHeroScale(param1:BattleHeroDescription) : Number
      {
         return param1.scale;
      }
      
      public function addProjectile(param1:ProjectileEntity, param2:BattleSkillDescription, param3:ProjectileMovementIdent = null, param4:EffectAnimationIdent = null) : void
      {
         var _loc7_:* = null;
         if(param3 == null)
         {
            param3 = ProjectileMovementIdent.DEFAULT;
         }
         if(param4 == null)
         {
            param4 = EffectAnimationIdent.BULLET;
         }
         var _loc6_:BattleHero = objects.getHeroByDescription(param2.hero);
         var _loc5_:EffectGraphicsProvider = this.asset.getHeroEffect(param2.tier,param4.name,param2.hero,getHeroScale(param2.hero),_loc6_ != null?_loc6_.view.assetPrefix:null);
         if(_loc5_ != EffectGraphicsProvider.MISSING)
         {
            _loc7_ = new BattleProjectile(graphics,objects,param3);
            objects.entities.add(param1,_loc7_);
            _loc7_.init(_loc5_);
            graphics.container.addChild(_loc7_.graphics);
            graphics.addFx(_loc7_);
         }
         else
         {
            trace("somewhere there is no fx asset for BULLET");
         }
      }
      
      public function addEffect(param1:Effect, param2:EffectHolder, param3:EffectAnimationIdent = null) : void
      {
         var _loc6_:BattleHero = objects.entities.getHero(param2);
         if(!_loc6_)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = EffectAnimationIdent.FX1;
         }
         var _loc4_:EffectGraphicsProvider = asset.getEffect(param3.name,param1,_loc6_.view.position.scale);
         if(!BattleEffect.hasVisibleRepresentation(param1,_loc4_))
         {
            return;
         }
         var _loc5_:BattleEffect = new BattleEffect(objects,graphics,_loc4_);
         objects.entities.add(param1,_loc5_);
         graphics.addFx(_loc5_);
      }
      
      public function addBody(param1:BattleBody, param2:Team) : IBattleBodyProxy
      {
         var _loc4_:BattleHero = objects.entities.getHero(param1);
         var _loc3_:BattleBodyEntry = new BattleBodyEntry();
         _loc3_.body = param1;
         _loc3_.team = param2;
         if(_loc4_ != null)
         {
            _loc3_.viewPosition = _loc4_.view.position;
            _loc3_.view = _loc4_.view;
            _loc3_.modelState = _loc4_.modelState;
            _loc3_.size = DataStorage.hero.getTitanById(_loc4_.hero.desc.heroId) != null?100:70;
         }
         else
         {
            _loc3_.size = 70;
         }
         return objects.addBodyEntry(_loc3_);
      }
      
      public function getBodyProxy(param1:BattleBody) : IBattleBodyProxy
      {
         return objects.getBody(param1);
      }
      
      public function addFx(param1:Hero, param2:EffectAnimationIdent, param3:SkillCast, param4:BattleSkillDescription = null) : void
      {
         var _loc6_:* = null;
         if(param4 == null)
         {
            if(param3.skill == null)
            {
               return;
               §§push(trace("BattleMediator.addFx skill not presented"));
            }
            else
            {
               param4 = param3.skill;
            }
         }
         var _loc5_:BattleHero = objects.entities.getHero(param1);
         if(_loc5_ == null)
         {
            return;
            §§push(trace("BattleMediator.addFx hero already disposed"));
         }
         else
         {
            if(param3.hero.getVisualDirection() < 0)
            {
               _loc6_ = new Matrix(-1,0,0,1);
            }
            var _loc7_:EffectGraphicsProvider = asset.getHeroEffect(param4.tier,param2.name,param4.hero,getHeroScale(param4.hero));
            graphics.createOnceHeroFx(_loc5_.view,_loc7_,_loc6_,param3.skill,false);
            return;
         }
      }
      
      public function addSceneFx(param1:Number, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Hero = null, param5:int = 0, param6:Number = 0) : void
      {
         var _loc8_:* = null;
         var _loc7_:EffectGraphicsProvider = asset.getHeroEffect(param3.tier,param2.name,param3.hero,getHeroScale(param3.hero));
         if(param5 == 0)
         {
            param5 = 1;
         }
         var _loc9_:Matrix = new Matrix(param5,0,0,1,param1,0);
         if(param4)
         {
            _loc8_ = objects.entities.getHero(param4);
            if(_loc8_)
            {
               _loc9_.ty = _loc8_.view.position.y;
               param6 = param6 + _loc8_.view.position.z;
            }
         }
         graphics.createOnceGlobalFx(_loc7_,_loc9_,param6,param3,false);
      }
      
      public function addProjectileFx(param1:ProjectileEntity, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Number = 0) : void
      {
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc5_:EffectGraphicsProvider = asset.getHeroEffect(param3.tier,param2.name,param3.hero,getHeroScale(param3.hero));
         var _loc9_:BattleProjectile = objects.entities.getProjectile(param1);
         if(_loc9_ != null)
         {
            graphics.createOnceGlobalFx(_loc5_,_loc9_.currentTransform,_loc9_.z + param4,param3);
         }
         else
         {
            _loc8_ = objects.entities.getHero(param1.skillCast.hero);
            if(_loc8_ != null)
            {
               _loc6_ = new ViewTransform();
               _loc7_ = _loc8_.view.anchors.ground;
               _loc6_.a = param1.body.vx > 0?1:-1;
               _loc6_.tx = param1.position;
               _loc6_.ty = _loc7_.y + param1.skillCast.skill.projectile.y * BattleEngine.ASSET_SCALE;
               _loc6_.tz = _loc7_.z + 30;
               graphics.createOnceGlobalFx(_loc5_,_loc6_,_loc6_.tz + param4,param3);
            }
         }
      }
      
      public function addProjectileHitFx(param1:ProjectileEntity, param2:Hero, param3:BattleSkillDescription) : void
      {
         var _loc9_:EffectGraphicsProvider = asset.getHeroEffect(param3.tier,EffectAnimationIdent.BULLET_HIT.name,param3.hero,getHeroScale(param3.hero));
         var _loc10_:BattleHero = objects.entities.getHero(param1.skillCast.hero);
         var _loc4_:BattleHero = objects.entities.getHero(param2);
         if(_loc9_ && _loc9_.front == null || _loc10_ == null || _loc4_ == null)
         {
            return;
         }
         var _loc6_:ViewTransform = new ViewTransform();
         var _loc8_:ViewPosition = _loc10_.view.anchors.ground;
         var _loc5_:ViewPosition = _loc4_.view.anchors.ground;
         _loc6_.a = param1.body.vx > 0?1:-1;
         _loc6_.tx = param1.position * 0.5 + _loc5_.x * 0.5;
         _loc6_.ty = _loc8_.y + param1.skillCast.skill.projectile.y * BattleEngine.ASSET_SCALE;
         _loc6_.tz = _loc8_.z + 30;
         var _loc7_:BattleFx = new BattleFx(true,_loc6_.tz);
         _loc7_.skin = _loc9_.createFrontSkin();
         _loc7_.selfTransform = _loc6_;
         graphics.addFx(_loc7_,param1.skillCast.skill);
         _loc7_.targetSpace = graphics.getGlobalAnimationTarget();
      }
      
      public function addBossHpBar(param1:Hero) : void
      {
         var _loc2_:BattleHero = objects.entities.getHero(param1);
         if(_loc2_)
         {
            graphics.addBossHpBar(_loc2_);
         }
      }
      
      public function addComplexFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param3 == EffectAnimationIdent.COMMON)
         {
            _loc5_ = asset.getCommonEffect(param4);
         }
         else
         {
            _loc5_ = asset.getHeroEffect(param2.tier,param3.name,param2.hero,getHeroScale(param2.hero));
         }
         if(_loc5_ != null)
         {
            _loc6_ = new ComplexAnimation(_loc5_,param1,objects,graphics,param2);
            graphics.addFx(_loc6_,param2);
         }
      }
      
      public function addTiledFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void
      {
         var _loc5_:* = null;
         if(param3 == EffectAnimationIdent.COMMON)
         {
            _loc5_ = asset.getCommonEffect(param4);
         }
         else
         {
            _loc5_ = asset.getHeroEffect(param2.tier,param3.name,param2.hero,getHeroScale(param2.hero));
         }
         param1.init(_loc5_.bounds);
         var _loc6_:TiledFxAnimation = new TiledFxAnimation(_loc5_,param1,objects,graphics);
         graphics.addFx(_loc6_,param2);
      }
      
      public function shakeScreen(param1:Number, param2:Number = 1, param3:Number = 0) : void
      {
         graphics.shakeScreen(param1,param2,param3);
      }
      
      public function freezeScreen(param1:Number) : void
      {
         graphics.freezeScreen(param1);
      }
      
      public function setSceneTimeOffset(param1:Number) : void
      {
         graphics.setSceneTimeOffset(param1);
      }
      
      public function setHeroCameraTracking(param1:Hero, param2:Boolean) : void
      {
         var _loc3_:BattleHero = objects.entities.getHero(param1);
         if(_loc3_)
         {
            graphics.setHeroCameraTracking(_loc3_.view,param2);
         }
      }
      
      public function displayEvent(param1:BattleDisplayEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc8_:* = null;
         signal_displayEvent.dispatch(param1);
         if(param1.type == TeamEffectEvent.TYPE)
         {
            _loc5_ = param1 as TeamEffectEvent;
            graphics.addTeamEffect(_loc5_.effect,_loc5_.icon);
         }
         else if(param1.type == SimpleFxEvent.TYPE)
         {
            _loc6_ = param1 as SimpleFxEvent;
            graphics.addFxEvent(_loc6_);
         }
         else if(param1.type == CustomManualActionEvent.TYPE)
         {
            _loc7_ = param1 as CustomManualActionEvent;
            graphics.addCustomManualActionEvent(_loc7_);
         }
         else if(param1.type == CustomAbilityEvent.TYPE)
         {
            _loc4_ = param1 as CustomAbilityEvent;
            if(objects.isPlayerSideTeam(_loc4_.ability.team))
            {
               graphics.addTeamSkill(_loc4_.ability);
            }
         }
         else if(param1.type == BattleTextEvent.TYPE)
         {
            _loc3_ = param1 as BattleTextEvent;
            if(_loc3_.text == "block")
            {
               graphics.text.block(graphics.getHeroView(_loc3_.hero.desc));
            }
            else if(_loc3_.text == "redirect")
            {
               graphics.text.redirect(graphics.getHeroView(_loc3_.hero.desc));
            }
         }
         else if(param1.type != GuiFxEvent.TYPE)
         {
            if(param1.type == TeamUltAnimationEvent.TYPE)
            {
               _loc9_ = param1 as TeamUltAnimationEvent;
               _loc2_ = new UltAnimationCast(_loc9_.skillCast,1.66666666666667,0.4,true,true);
               graphics.ultAnimation(_loc2_);
            }
            else if(param1.type == TitanArtifactGuiFxEvent.TYPE)
            {
               _loc8_ = param1 as TitanArtifactGuiFxEvent;
               graphics.addGuiFx(new TitanArtifactBattleGuiFx(_loc8_,asset));
            }
         }
      }
      
      public function area(param1:Number, param2:Number, param3:SkillCast) : void
      {
         if(BattleHero.BATTLE_INSPECTOR && param3.skill != null)
         {
            graphics.highlightArea(param1,param2,param3.skill.tier,param3.hero);
         }
      }
   }
}
