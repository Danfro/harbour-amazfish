#ifndef ABSTRACTFETCHOPERATION_H
#define ABSTRACTFETCHOPERATION_H

#include "abstractoperation.h"

#include <QDateTime>
#include <QString>

class AbstractFetchOperation : public AbstractOperation
{
public:
    explicit AbstractFetchOperation(bool isZeppOs = false);

    bool handleMetaData(const QByteArray &meta) override;

private:
    QDateTime m_startDate;
    QString m_lastSyncKey;
    bool m_abort = false;
    bool m_isZeppOs = false;

    bool handleStartDateResponse(const QByteArray &value);
    bool handleFetchDataResponse(const QByteArray &value);
    bool sendAck();

protected:
    void setStartDate(const QDateTime &sd);
    QDateTime startDate() const;

    void setLastSyncKey(const QString &key);
    QDateTime lastActivitySync();
    void saveLastActivitySync(qint64 millis);

    void setAbort(bool abort);
    virtual bool processBufferedData() = 0;


    QBLEService *m_service = nullptr;
};

#endif // ABSTRACTFETCHOPERATION_H
