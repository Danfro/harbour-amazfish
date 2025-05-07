#include "devicefactory.h"
#include "asteroidosdevice.h"
#include "huamidevice.h"
#include "gtsdevice.h"
#include "neodevice.h"
#include "biplitedevice.h"
#include "pebbledevice.h"
#include "pinetimejfdevice.h"
#include "banglejsdevice.h"
#include "bipsdevice.h"
#include "gts2device.h"
#include "gtrdevice.h"
#include "gtr2device.h"
#include "dk08device.h"
#include "zepposdevice.h"

using DeviceCreator = std::function<AbstractDevice*(const QString &)>;

static const QMap<QString, DeviceCreator> deviceMap = {
    { "Amazfit Bip Watch", [](const QString &name) { return new BipDevice(name); } },
    { "Amazfit GTS", [](const QString &name) { return new GtsDevice(name); } },
    { "Amazfit Neo", [](const QString &name) { return new NeoDevice(name); } },
    { "Amazfit GTS 2", [](const QString &name) { return new Gts2Device(name); } },
    { "Amazfit GTR", [](const QString &name) { return new GtrDevice(name); } },
    { "Amazfit GTR 2", [](const QString &name) { return new Gtr2Device(name); } },
    { "Amazfit Bip Lite", [](const QString &name) { return new BipLiteDevice(name); } },
    { "Amazfit Bip S", [](const QString &name) { return new BipSDevice(name); } },
    { "Amazfit Stratos 3", [](const QString &name) { return new GtsDevice(name); } },
    { "Mi Smart Band 4", [](const QString &name) { return new BipLiteDevice(name); } },
    { "Amazfit Balance", [](const QString &name) { return new ZeppOSDevice(name); } },
    { "InfiniTime", [](const QString &name) { return new PinetimeJFDevice(name); } },
    { "Pebble", [](const QString &name) { return new PebbleDevice(name); } },
    { "Bangle.js", [](const QString &name) { return new BangleJSDevice(name); } },
    { "Kospet DK08", [](const QString &name) { return new DK08Device(name); } },
    { "AsteroidOS", [](const QString &name) { return new AsteroidOSDevice(name); } },

    { "Amazfit Cor", [](const QString &name) { return new BipLiteDevice(name); } },
    { "Mi Band 3", [](const QString &name) { return new BipLiteDevice(name); } },
    { "Mi Band 2", [](const QString &name) { return new BipLiteDevice(name); } },
    };

AbstractDevice* DeviceFactory::createDevice(const QString &deviceName, const QString &deviceType)
{
    qDebug() << Q_FUNC_INFO <<": requested device of type:" << deviceName << deviceType;

    if (deviceMap.contains(deviceType)) {
        return deviceMap.value(deviceType)(deviceName);
    }

    qWarning() << "DeviceCreator not found";
    return nullptr;
}
