

/**
 * Removes duplicate rows from the current sheet.
 */
function removeDuplicates(sheet) {
    const data = sheet.getDataRange().getValues();
    const uniqueData = {};
    for (let row of data) {
        const key = row.join();
        uniqueData[key] = uniqueData[key] || row;
    }
    sheet.clearContents();
    const newData = Object.values(uniqueData);
    sheet.getRange(1, 1, newData.length, newData[0].length).setValues(newData);
}