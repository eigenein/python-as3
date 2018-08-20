package game.battle.controller.hero
{
   import battle.DamageValue;
   import battle.Hero;
   import battle.data.DamageType;
   import battle.proxy.HeroViewAnchors;
   import battle.proxy.IHeroProxy;
   import battle.proxy.empty.EmptyHeroProxy;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.proxy.idents.SwitchHeroAssetIdent;
   import battle.skills.SkillCast;
   import flash.geom.Matrix;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.position.BattleBodyState;
   import game.battle.controller.position.IHeroController;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.BattleHeroEffectMapping;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.hero.AnimationIdent;
   import game.battle.view.hero.HeroView;
   import game.battle.view.hero.HeroViewEnergyBar;
   import game.battle.view.ult.UltAnimationCast;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skills.SkillDescription;
   import game.view.gui.tutorial.Tutorial;
   import org.osflash.signals.Signal;
   
   public class BattleHeroController implements IHeroProxy, IHeroController
   {
       
      
      protected var _hero:Hero;
      
      protected var view:HeroView;
      
      protected var graphics:BattleGraphicsMethodProvider;
      
      public const modelState:BattleBodyState = new BattleBodyState();
      
      private var assetSwitcher:SwitchHeroAssetManager;
      
      private var energyBar:HeroViewEnergyBar;
      
      private var previousHpForInspect:int;
      
      private var currentHpForInspect:int;
      
      public const signal_deathAnimationBegin:Signal = new Signal();
      
      public const signal_deathAnimationEnd:Signal = new Signal();
      
      public function BattleHeroController(param1:Hero, param2:HeroView, param3:BattleGraphicsMethodProvider, param4:BattleMediatorObjects)
      {
         super();
         this._hero = param1;
         this.view = param2;
         this.graphics = param3;
         param2.statusBar.defineHpValue(_hero.state.hp,_hero.updatedStats().hp);
         param1.enemyTeam.onEmpty.add(onEnemyTeamEmpty);
         assetSwitcher = new SwitchHeroAssetManager(param2,param3,param1.desc);
         if(BattleHero.BATTLE_INSPECTOR)
         {
            energyBar = new HeroViewEnergyBar(param2.statusBar,param1.state.energy);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function unlink() : void
      {
         _hero.viewProxy = EmptyHeroProxy.instance;
      }
      
      public function get hero() : Hero
      {
         return _hero;
      }
      
      public function advanceTime(param1:Number) : void
      {
         view.updatePosition();
         if(hero.canMove.isEnabled() || hero.speed.get_value() == 0)
         {
            view.idlePlaybackSpeed = 1;
         }
         else
         {
            view.idlePlaybackSpeed = 0.3;
         }
         var _loc2_:Number = hero.speed.get_value() / hero.speed.initialValue;
         view.globalPlaybackSpeed = _loc2_;
      }
      
      public function onHpModify(param1:Number) : void
      {
         previousHpForInspect = currentHpForInspect;
         currentHpForInspect = _hero.state.hp;
         view.setHp(_hero.state.hp,_hero.updatedStats().hp);
      }
      
      public function onEnergyModify(param1:Number) : void
      {
         if(param1 == 0)
         {
            return;
         }
         if(energyBar)
         {
            energyBar.setValue(_hero.state.energy);
         }
         graphics.text.energyDefault(view,(param1 > 0?"+":"") + int(param1),50);
      }
      
      public function energyBurned(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         graphics.text.energyModified(view,"-" + int(param1) / 10 + "%",-60);
      }
      
      public function energyBlocked(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         graphics.text.energyCanceled(view,"+" + int(param1) / 10 + "%",-60);
      }
      
      public function energyGenerated(param1:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         graphics.text.energyModified(view,"+" + int(param1) / 10 + "%",100);
      }
      
      public function onTakeDamage(param1:DamageValue) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1.blocked)
         {
            return;
         }
         if(param1.immune)
         {
            graphics.text.immune(view);
         }
         else if(param1.missed)
         {
            graphics.text.missed(view);
         }
         else if(param1.dodged)
         {
            _loc2_ = _hero.updatedStats().dodge;
            graphics.text.dodged(view);
            if(param1.source.hero != null)
            {
               _loc5_ = param1.source.hero.updatedStats().antidodge;
               graphics.text.debug(view,"dodge " + _loc2_ + "/" + (_loc2_ + _loc5_));
            }
            _loc3_ = null;
            _loc6_ = param1.source != null?param1.source.hero:null;
            if(_loc6_ != null)
            {
               _loc7_ = graphics.getHeroView(_loc6_.desc);
               if(_loc7_ != null && _loc7_.position.x > view.position.x)
               {
                  _loc3_ = new Matrix(-1);
               }
            }
            graphics.createOnceHeroFx(view,graphics.getDodgeFx(),_loc3_,null,true);
         }
         else if(param1.resultValue == 0)
         {
            graphics.text.debug(view,"0 dmg");
         }
         else
         {
            _loc6_ = param1.source != null?param1.source.hero:null;
            if(_loc6_)
            {
               _loc7_ = graphics.getHeroView(_loc6_.desc);
               if(_loc7_)
               {
                  _loc8_ = _loc7_.createEffectGraphicsProvider(BattleHeroEffectMapping.getAnimationByString(EffectAnimationIdent.HIT.name,param1.source.skill.tier));
               }
               else
               {
                  _loc8_ = graphics.getHeroSkillOnHit(param1.source.skill.tier,_loc6_.desc);
               }
               if(_loc8_ != EffectGraphicsProvider.MISSING)
               {
                  _loc3_ = null;
                  if(_loc7_ != null && _loc7_.position.x > view.position.x)
                  {
                     _loc3_ = new Matrix(-1);
                  }
                  graphics.createOnceHeroFx(view,_loc8_,_loc3_,null,false);
               }
            }
            graphics.text.debug(view,int(100 * param1.resultValue / param1.sourceValue) + "%");
            if(param1.type == DamageType.PHYSICAL)
            {
               if(param1.source.hero != null)
               {
                  _loc2_ = param1.source.hero.updatedStats().physicalCritChance;
                  _loc5_ = _hero.updatedStats().anticrit;
                  if(param1.crited)
                  {
                     graphics.text.debug(view,"crit " + param1.critRoll + " [" + _loc2_ + ".." + (_loc2_ + _loc5_) + "]");
                  }
               }
            }
            _loc4_ = createDamageTooltip(param1);
            if(param1.crited)
            {
               if(param1.type == DamageType.PHYSICAL)
               {
                  graphics.text.critDamagePhysical(view,param1.resultValue,_loc4_);
               }
               else if(param1.type == DamageType.DOT)
               {
                  graphics.text.critDamagePure(view,param1.resultValue,_loc4_);
               }
               else if(param1.type == DamageType.MAGIC)
               {
                  graphics.text.critDamageMagic(view,param1.resultValue,_loc4_);
               }
            }
            else if(param1.type == DamageType.PHYSICAL)
            {
               graphics.text.damagePhysical(view,param1.resultValue,_loc4_);
            }
            else if(param1.type == DamageType.DOT)
            {
               graphics.text.damagePure(view,param1.resultValue,_loc4_);
            }
            else if(param1.type == DamageType.MAGIC)
            {
               graphics.text.damageMagic(view,param1.resultValue,_loc4_);
            }
            if(param1.type != DamageType.SILENT)
            {
               graphics.createOnceHeroFx(view,graphics.getHurtFx(),null,null,true);
            }
         }
      }
      
      protected function createDamageTooltip(param1:DamageValue) : String
      {
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         if(BattleHero.BATTLE_INSPECTOR == false)
         {
            return null;
         }
         var _loc5_:int = currentHpForInspect - previousHpForInspect;
         if(param1.source.hero != null)
         {
            _loc8_ = param1.source.hero.desc.heroId;
            _loc4_ = DataStorage.hero.getUnitById(_loc8_);
            if(_loc4_)
            {
               _loc3_ = _loc4_.name + " ";
            }
            else
            {
               _loc3_ = param1.source.hero.desc.name + " ";
            }
         }
         else
         {
            _loc3_ = "";
         }
         if(param1.source.hero != null)
         {
            _loc2_ = DataStorage.skill.getByHeroAndTier(param1.source.hero.desc.heroId,param1.source.skill.tier);
            if(_loc2_)
            {
               _loc6_ = param1.source.skill.tier + ". " + _loc2_.name + " ";
            }
            else
            {
               _loc6_ = param1.source.skill.tier + " ";
            }
         }
         else
         {
            _loc6_ = "";
         }
         var _loc7_:String = "(Входящий урон: " + param1.sourceValue + ", Изменение здоровья: " + _loc5_ + ")";
         return _loc3_ + _loc6_ + _loc7_;
      }
      
      public function onTakeHeal(param1:Number) : void
      {
         if(param1 == 0)
         {
            return;
         }
         graphics.text.heal(view,param1);
      }
      
      public function onDie() : void
      {
         assetSwitcher.die();
         view.die();
         disableAndStopWhenCompleted();
      }
      
      public function disableAndStopWhenCompleted() : void
      {
         view.disableAndStopWhenCompleted();
         view.signal_deathAnimationCompleted.add(handler_deathAnimationCompleted);
         signal_deathAnimationBegin.dispatch();
         if(energyBar)
         {
            energyBar.dispose();
         }
      }
      
      public function ultAnimation(param1:SkillCast) : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:* = NaN;
         var _loc8_:* = NaN;
         var _loc7_:* = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:* = null;
         var _loc3_:UnitDescription = DataStorage.hero.getUnitById(_hero.desc.heroId);
         var _loc4_:Boolean = _loc3_ != null && (_loc3_.unitType == "titan" || _loc3_.unitType == "hero");
         if(_loc4_ && param1.skill.tier == 1)
         {
            _loc6_ = _hero.team.immediateUltimates;
            if(_loc6_)
            {
               _loc5_ = 0.3;
               _loc8_ = 0;
            }
            else
            {
               _loc5_ = 0;
               _loc8_ = 0.8;
            }
            _loc7_ = 0.4;
            _loc9_ = _loc3_.unitType == "titan"?1:1.45;
            _loc2_ = new UltAnimationCast(param1,_loc5_ + param1.skill.animationDelay + _loc8_,_loc7_,_loc6_,_loc6_);
            _loc2_.setHero(view,_loc5_,_loc9_);
            graphics.ultAnimation(_loc2_);
            if(_loc6_)
            {
               graphics.showUltName(_hero.desc.heroId,param1.skill.tier);
               view.isMoving = 0;
               view.stopAny();
            }
            setAnimation(HeroAnimationIdent.ULT,null);
         }
         else
         {
            setAnimation(HeroAnimationIdent.ULT,null);
         }
      }
      
      public function setAnimation(param1:HeroAnimationIdent, param2:String) : void
      {
         if(param2)
         {
            view.setAnimation(AnimationIdent.fromBattleAnimationIdent(param1),param1.name + param2);
         }
         else if(param1)
         {
            view.setAnimation(AnimationIdent.fromBattleAnimationIdent(param1),null);
         }
      }
      
      public function stopAnimation(param1:HeroAnimationIdent, param2:Boolean) : void
      {
         view.stopAnimation(AnimationIdent.fromBattleAnimationIdent(param1),param2);
      }
      
      public function setAsset(param1:SwitchHeroAssetIdent, param2:Boolean = false) : void
      {
         if(param2)
         {
            assetSwitcher.setDefault(param1);
         }
         else
         {
            assetSwitcher.setTemporary(param1);
         }
      }
      
      public function setYPosition(param1:Number) : void
      {
         view.position.y = param1;
      }
      
      public function getAnchors() : HeroViewAnchors
      {
         return view.anchors;
      }
      
      public function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         view.setWeaponRotation(param1,param2,param3,param4);
      }
      
      public function action_userInput() : void
      {
         _hero.actionUserInput();
         Tutorial.events.triggerEvent_battle_userAction(_hero.desc.heroId);
      }
      
      private function handler_deathAnimationCompleted() : void
      {
         signal_deathAnimationEnd.dispatch();
      }
      
      protected function onEnemyTeamEmpty() : void
      {
         if(energyBar)
         {
            energyBar.dispose();
         }
         if(hero.desc.state.isDead)
         {
            if(!view.isDying)
            {
               onDie();
            }
         }
         else
         {
            assetSwitcher.enemyTeamEmpty();
            view.stopLoop();
            view.transform.removeAllContainerAnimations();
         }
      }
   }
}
