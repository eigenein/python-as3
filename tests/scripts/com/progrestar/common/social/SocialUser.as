package com.progrestar.common.social
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SocialUser extends EventDispatcher
   {
      
      public static const SEX_NONE:uint = 0;
      
      public static const SEX_MALE:uint = 1;
      
      public static const SEX_FEMALE:uint = 2;
       
      
      public var hasMobile:Boolean;
      
      private var _socialSex:uint;
      
      public var canPost:Boolean;
      
      public var localeUncuted:String = "";
      
      public var firstName:String = "";
      
      public var lastName:String = "";
      
      public var nickName:String = "";
      
      public var id:String;
      
      public var shortId:String;
      
      public var photos:Array;
      
      public var male:Boolean;
      
      private var netUid:NetworkUid;
      
      public var isAppFriend:Boolean = false;
      
      public var isFriend:Boolean = false;
      
      public var isAppUser:Boolean = false;
      
      public var itsMe:Boolean = false;
      
      public var bdate:Number = 0;
      
      public var link:String;
      
      public var online:Boolean;
      
      public var balance:int;
      
      private var _mediumPhoto:Bitmap;
      
      private var _mediumPhotoLoader:Loader;
      
      private var reloader:Loader;
      
      private var _city:String;
      
      public var country:String;
      
      private var _locale:String;
      
      private var _age:uint = 0;
      
      public var cityName:String;
      
      public var countryName:String;
      
      public function SocialUser()
      {
         photos = [];
         super();
      }
      
      public function get age() : uint
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_age == 0 && bdate > 0)
         {
            _loc2_ = new Date(bdate * 1000);
            _loc1_ = new Date();
            _loc1_.setFullYear(_loc1_.fullYear - _loc2_.fullYear,_loc1_.month - _loc2_.month,_loc1_.date - _loc2_.date);
            _age = _loc1_.fullYear > 0?_loc1_.fullYear:0;
         }
         return _age;
      }
      
      public function get city() : String
      {
         return _city;
      }
      
      public function set city(param1:String) : void
      {
         _city = param1;
      }
      
      public function get locale() : String
      {
         return _locale;
      }
      
      public function set locale(param1:String) : void
      {
         _locale = param1;
      }
      
      public function get sex() : String
      {
         return !!male?"male":"female";
      }
      
      public function get socialSex() : uint
      {
         return _socialSex;
      }
      
      public function set socialSex(param1:uint) : void
      {
         _socialSex = param1;
      }
      
      public function setMediumPhotoAsset(param1:MovieClip) : void
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc2_.draw(param1,null,null,null,null,true);
         _mediumPhoto = new Bitmap(_loc2_);
         commit();
      }
      
      public function getFullName() : String
      {
         return (!!this.firstName?this.firstName:"") + (!!this.lastName?" " + this.lastName:"");
      }
      
      public function get mediumPhoto() : Bitmap
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(!_mediumPhoto && !_mediumPhotoLoader && photos && photos[1])
         {
            _loc3_ = SocialAdapter.instance.SOCIAL_NO_PHOTO_PATTERNS;
            if(_loc3_ && _loc3_.length)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc3_.length)
               {
                  if(_loc3_[_loc2_] is RegExp && (_loc3_[_loc2_] as RegExp).test(photos[1]))
                  {
                     photos[1] = null;
                     _mediumPhoto = new Bitmap(null);
                     return _mediumPhoto;
                  }
                  _loc2_++;
               }
            }
            _mediumPhotoLoader = new Loader();
            _mediumPhotoLoader.load(new URLRequest(photos[1]),new LoaderContext(true));
            _mediumPhotoLoader.contentLoaderInfo.addEventListener("complete",mediumPhotoLoadComplete);
            _mediumPhotoLoader.contentLoaderInfo.addEventListener("ioError",mediumPhotoLoadError);
            _mediumPhotoLoader.contentLoaderInfo.addEventListener("securityError",mediumPhotoLoadError);
            return null;
         }
         if(_mediumPhoto)
         {
            _loc1_ = _mediumPhoto.bitmapData;
            _loc1_ = !!_loc1_?_mediumPhoto.bitmapData.clone():null;
            return new Bitmap(_loc1_,"auto",true);
         }
         if(!photos[1])
         {
            _mediumPhoto = new Bitmap(null);
            return _mediumPhoto;
         }
         return null;
      }
      
      public function set mediumPhoto(param1:Bitmap) : void
      {
         _mediumPhoto = param1;
         commit();
      }
      
      private function mediumPhotoLoadComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         try
         {
            _loc2_ = _mediumPhotoLoader.content as Bitmap;
         }
         catch(e:SecurityError)
         {
            _loc4_ = 4;
            trace(e);
            try
            {
               _loc3_ = LoaderInfo(param1.target);
               _loc5_ = _loc3_.bytes;
               reloader = new Loader();
               reloader.loadBytes(_loc5_);
               reloader.contentLoaderInfo.addEventListener("complete",reloaderComplete);
            }
            catch(e:*)
            {
               mediumPhotoLoadError();
            }
            return;
         }
         catch(e:*)
         {
            mediumPhotoLoadError();
            return;
         }
         _mediumPhoto = _loc2_;
         _mediumPhotoLoader.contentLoaderInfo.removeEventListener("complete",mediumPhotoLoadComplete);
         _mediumPhotoLoader.contentLoaderInfo.removeEventListener("ioError",mediumPhotoLoadError);
         _mediumPhotoLoader.contentLoaderInfo.removeEventListener("securityError",mediumPhotoLoadError);
         _mediumPhotoLoader = null;
         commit();
      }
      
      private function reloaderComplete(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         try
         {
            _loc4_ = reloader.content as DisplayObject;
            _loc3_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc3_.draw(_loc4_,null,null,null,null,true);
            _loc2_ = new Bitmap(_loc3_,"auto",true);
            _mediumPhoto = _loc2_;
            _mediumPhotoLoader.contentLoaderInfo.removeEventListener("complete",mediumPhotoLoadComplete);
            _mediumPhotoLoader.contentLoaderInfo.removeEventListener("ioError",mediumPhotoLoadError);
            _mediumPhotoLoader.contentLoaderInfo.removeEventListener("securityError",mediumPhotoLoadError);
            _mediumPhotoLoader = null;
            commit();
            return;
         }
         catch(e:*)
         {
            mediumPhotoLoadError();
            return;
         }
      }
      
      private function commit() : void
      {
         dispatchEvent(new Event("change"));
      }
      
      private function mediumPhotoLoadError(param1:Event = null) : void
      {
         _mediumPhoto = new Bitmap(null);
      }
      
      override public function toString() : String
      {
         return "[SocialUser(" + firstName + " " + lastName + ")]";
      }
   }
}
